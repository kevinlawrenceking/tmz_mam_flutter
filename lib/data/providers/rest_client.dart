import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

abstract class IRestClient {
  /// Sends an HTTP DELETE request with the given headers to the given URL.
  Future<http.Response> delete({
    required String endPoint,
    String? authToken,
    Map<String, String>? headers,
  });

  /// Sends an HTTP GET request with the given headers to the given URL.
  Future<http.Response> get({
    required String endPoint,
    String? authToken,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  });

  /// Sends an HTTP PATCH request with the given headers and body to the given
  /// URL.
  ///
  /// [body] sets the body of the request.
  Future<http.Response> patch({
    required String endPoint,
    String? authToken,
    Map<String, String>? headers,
    Object? body,
  });

  /// Sends an HTTP POST request with the given headers and body to the given
  /// URL.
  ///
  /// [body] sets the body of the request.
  Future<http.Response> post({
    required String endPoint,
    String? authToken,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    Object? body,
  });

  /// Sends an HTTP PUT request with the given headers and body to the given
  /// URL.
  ///
  /// [body] sets the body of the request.
  Future<http.Response> put({
    required String endPoint,
    String? authToken,
    Map<String, String>? headers,
    Object? body,
  });

  Future<http.StreamedResponse> sendFile({
    required String endPoint,
    required String fileName,
    required int fileSize,
    required Uint8List fileData,
    required String mimeType,
    String? authToken,
    Map<String, String>? headers,
  });
}

class RestClient implements IRestClient {
  final String _baseUrl;
  final String _appIdentifier;
  final _HttpClient _client;

  RestClient({
    required String baseUrl,
    required String appIdentifier,
  })  : _baseUrl = '${baseUrl.replaceAll(r'/+$', '')}/',
        _appIdentifier = appIdentifier,
        _client = _HttpClient(
          appIdentifier: appIdentifier,
        );

  @override
  Future<http.Response> delete({
    required String endPoint,
    String? authToken,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$_baseUrl${endPoint.replaceAll(RegExp('^/+'), '')}');

    final mergedHeaders = {
      'cache-control': 'no-cache',
      'x-app': _appIdentifier,
    };

    if (headers?.isNotEmpty ?? false) {
      mergedHeaders.addAll(headers!);
    }

    if (authToken?.isNotEmpty ?? false) {
      mergedHeaders['authorization'] = 'Bearer $authToken';
    }

    final response = await _client.delete(
      url,
      headers: mergedHeaders,
    );

    return response;
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
      'cache-control': 'no-cache',
      'x-app': _appIdentifier,
    };

    if (headers?.isNotEmpty ?? false) {
      mergedHeaders.addAll(headers!);
    }

    if (authToken?.isNotEmpty ?? false) {
      mergedHeaders['authorization'] = 'Bearer $authToken';
    }

    final response = await _client.get(
      url,
      headers: mergedHeaders,
    );

    return response;
  }

  @override
  Future<http.Response> patch({
    required String endPoint,
    String? authToken,
    Map<String, String>? headers,
    Object? body,
  }) async {
    final url = Uri.parse('$_baseUrl${endPoint.replaceAll(RegExp('^/+'), '')}');

    final mergedHeaders = {
      'cache-control': 'no-cache',
      'content-type': 'application/json',
      'x-app': _appIdentifier,
    };

    if (headers?.isNotEmpty ?? false) {
      mergedHeaders.addAll(headers!);
    }

    if (authToken?.isNotEmpty ?? false) {
      mergedHeaders['authorization'] = 'Bearer $authToken';
    }

    final response = await _client.patch(
      url,
      headers: mergedHeaders,
      body:
          (body != null) ? ((body is String) ? body : json.encode(body)) : null,
    );

    return response;
  }

  @override
  Future<http.Response> post({
    required String endPoint,
    String? authToken,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    Object? body,
  }) async {
    final url = Uri.parse('$_baseUrl${endPoint.replaceAll(RegExp('^/+'), '')}')
        .replace(queryParameters: queryParams);

    final mergedHeaders = {
      'cache-control': 'no-cache',
      'content-type': 'application/json',
      'x-app': _appIdentifier,
    };

    if (headers?.isNotEmpty ?? false) {
      mergedHeaders.addAll(headers!);
    }

    if (authToken?.isNotEmpty ?? false) {
      mergedHeaders['authorization'] = 'Bearer $authToken';
    }

    final response = await _client.post(
      url,
      headers: mergedHeaders,
      body:
          (body != null) ? ((body is String) ? body : json.encode(body)) : null,
    );

    return response;
  }

  @override
  Future<http.Response> put({
    required String endPoint,
    String? authToken,
    Map<String, String>? headers,
    Object? body,
  }) async {
    final url = Uri.parse('$_baseUrl${endPoint.replaceAll(RegExp('^/+'), '')}');

    final mergedHeaders = {
      'cache-control': 'no-cache',
      'content-type': 'application/json',
      'x-app': _appIdentifier,
    };

    if (headers?.isNotEmpty ?? false) {
      mergedHeaders.addAll(headers!);
    }

    if (authToken?.isNotEmpty ?? false) {
      mergedHeaders['authorization'] = 'Bearer $authToken';
    }

    final response = await _client.put(
      url,
      headers: mergedHeaders,
      body:
          (body != null) ? ((body is String) ? body : json.encode(body)) : null,
    );

    return response;
  }

  @override
  Future<http.StreamedResponse> sendFile({
    required String endPoint,
    required String fileName,
    required int fileSize,
    required Uint8List fileData,
    required String mimeType,
    String? authToken,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse('$_baseUrl${endPoint.replaceAll(RegExp('^/+'), '')}');

    final mergedHeaders = <String, String>{};

    if (headers?.isNotEmpty ?? false) {
      mergedHeaders.addAll(headers!);
    }

    if (authToken?.isNotEmpty ?? false) {
      mergedHeaders['authorization'] = 'Bearer $authToken';
    }

    final request = http.MultipartRequest('POST', url)
      ..headers.addAll(mergedHeaders);

    request.files.add(
      http.MultipartFile(
        'file',
        Stream.value(fileData),
        fileSize,
        filename: fileName,
        contentType: MediaType.parse(mimeType),
      ),
    );

    final response = await request.send();

    return response;
  }
}

class _HttpClient extends http.BaseClient {
  final http.Client _client;
  final String _appIdentifier;

  _HttpClient({
    required String appIdentifier,
  })  : _appIdentifier = appIdentifier,
        _client = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    request.headers['cache-control'] = 'no-cache';
    request.headers['x-app'] = _appIdentifier;
    return _client.send(request);
  }
}
