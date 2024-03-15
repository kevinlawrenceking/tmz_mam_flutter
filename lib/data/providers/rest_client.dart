import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const String kUserAgent = 'TMZDAMZ';

// this should be updated to pull the actual version...
const String appVersion = '1.0';

abstract class IRestClient {
  /// Sends an HTTP GET request with the given headers to the given URL.
  Future<http.Response> get({
    required String endPoint,
    String? authToken,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  });

  /// Sends an HTTP POST request with the given headers and body to the given
  /// URL.
  ///
  /// [body] sets the body of the request. It can be a [String], a [List<int>]
  /// or a [Map<String, String>]. If it's a String, it's encoded using UTF-8
  /// and used as the body of the request. The content-type of the request will
  /// default to "text/plain".
  ///
  /// If [body] is a List, it's used as a list of bytes for the body of the
  /// request.
  ///
  /// If [body] is a Map, it's encoded as form fields using UTF-8. The
  /// content-type of the request will be set to
  /// `"application/x-www-form-urlencoded"`; this cannot be overridden.
  Future<http.Response> post({
    required String endPoint,
    String? authToken,
    Map<String, String>? headers,
    Object? body,
  });
}

class RestClient implements IRestClient {
  final String _baseUrl;
  http.Client? _client;

  RestClient({
    required String baseUrl,
  })  : _baseUrl = '${baseUrl.replaceAll(r'/+$', '')}/',
        _client = http.Client();

  void dispose() {
    _client?.close();
    _client = null;
  }

  @override
  Future<http.Response> get({
    required String endPoint,
    String? authToken,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$_baseUrl${endPoint.replaceAll(RegExp('^/+'), '')}')
        .replace(queryParameters: queryParams);

    final mergedHeaders = {
      'Cache-Control': 'no-cache',
    };

    if (!kIsWeb) {
      mergedHeaders['User-Agent'] = '$kUserAgent/$appVersion';
    }

    if (headers?.isNotEmpty ?? false) {
      mergedHeaders.addAll(headers!);
    }

    if (authToken?.isNotEmpty ?? false) {
      mergedHeaders['Authorization'] = 'Bearer $authToken';
    }

    final response = await http.get(
      url,
      headers: mergedHeaders,
    );

    return response;
  }

  @override
  Future<http.Response> post({
    required String endPoint,
    String? authToken,
    Map<String, String>? headers,
    Object? body,
  }) async {
    final url = Uri.parse('$_baseUrl${endPoint.replaceAll(RegExp('^/+'), '')}');

    final mergedHeaders = {
      'Cache-Control': 'no-cache',
      'Content-Type': 'application/json',
    };

    if (!kIsWeb) {
      mergedHeaders['User-Agent'] = '$kUserAgent/$appVersion';
    }

    if (headers?.isNotEmpty ?? false) {
      mergedHeaders.addAll(headers!);
    }

    if (authToken?.isNotEmpty ?? false) {
      mergedHeaders['Authorization'] = 'Bearer $authToken';
    }

    final response = await http.post(
      url,
      headers: mergedHeaders,
      body: body,
    );

    return response;
  }
}
