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

  RestClient({
    required String baseUrl,
    required String appIdentifier,
  })  : _baseUrl = '${baseUrl.replaceAll(r'/+$', '')}/',
        _appIdentifier = appIdentifier;

  @override
  Future<http.Response> delete({
    required String endPoint,
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

    final request = http.Request('DELETE', url);

    request.headers.addAll(mergedHeaders);

    return _withClient((client) async {
      final response = await client.send(request);
      final responseBody = await response.stream.bytesToString();

      return http.Response(
        responseBody,
        response.statusCode,
        request: request,
      );
    });
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

    final mergedHeaders = <String, String>{};

    if (headers?.isNotEmpty ?? false) {
      mergedHeaders.addAll(headers!);
    }

    if (authToken?.isNotEmpty ?? false) {
      mergedHeaders['authorization'] = 'Bearer $authToken';
    }

    final request = http.Request('GET', url);

    request.headers.addAll(mergedHeaders);

    return _withClient((client) async {
      final response = await client.send(request);
      final responseBody = await response.stream.bytesToString();

      return http.Response(
        responseBody,
        response.statusCode,
        request: request,
      );
    });
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
      'content-type': 'application/json',
    };

    if (headers?.isNotEmpty ?? false) {
      mergedHeaders.addAll(headers!);
    }

    if (authToken?.isNotEmpty ?? false) {
      mergedHeaders['authorization'] = 'Bearer $authToken';
    }

    final request = http.Request('PATCH', url);

    request.headers.addAll(mergedHeaders);

    if (body != null) {
      request.body = (body is String) ? body : json.encode(body);
    }

    return _withClient((client) async {
      final response = await client.send(request);
      final responseBody = await response.stream.bytesToString();

      return http.Response(
        responseBody,
        response.statusCode,
        request: request,
      );
    });
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
      'content-type': 'application/json',
    };

    if (headers?.isNotEmpty ?? false) {
      mergedHeaders.addAll(headers!);
    }

    if (authToken?.isNotEmpty ?? false) {
      mergedHeaders['authorization'] = 'Bearer $authToken';
    }

    final request = http.Request('POST', url);

    request.headers.addAll(mergedHeaders);

    if (body != null) {
      request.body = (body is String) ? body : json.encode(body);
    }

    return _withClient((client) async {
      final response = await client.send(request);
      final responseBody = await response.stream.bytesToString();

      return http.Response(
        responseBody,
        response.statusCode,
        request: request,
      );
    });
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
      'content-type': 'application/json',
    };

    if (headers?.isNotEmpty ?? false) {
      mergedHeaders.addAll(headers!);
    }

    if (authToken?.isNotEmpty ?? false) {
      mergedHeaders['authorization'] = 'Bearer $authToken';
    }

    final request = http.Request('PUT', url);

    request.headers.addAll(mergedHeaders);

    if (body != null) {
      request.body = (body is String) ? body : json.encode(body);
    }

    return _withClient((client) async {
      final response = await client.send(request);
      final responseBody = await response.stream.bytesToString();

      return http.Response(
        responseBody,
        response.statusCode,
        request: request,
      );
    });
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

    final request = http.MultipartRequest('POST', url);

    request.headers.addAll(mergedHeaders);

    request.files.add(
      http.MultipartFile(
        'file',
        Stream.value(fileData),
        fileSize,
        filename: fileName,
        contentType: MediaType.parse(mimeType),
      ),
    );

    return _withClient((client) async {
      final response = await client.send(request);

      return response;
    });
  }

  Future<T> _withClient<T>(
    Future<T> Function(_HttpClient client) fn,
  ) async {
    final client = _HttpClient(
      appIdentifier: _appIdentifier,
    );

    try {
      return await fn(client);
    } finally {
      client.close();
    }
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
