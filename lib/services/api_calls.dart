// ignore_for_file: unused_element

import 'dart:convert';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class UsersCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'users',
      apiUrl:
          'https://12ebb237-1b2a-42fc-88f9-05ac1898ebbc.mock.pstmn.io/users/',
      callType: ApiCallType.get,
      headers: {
        'apiKey': 'ec2d2742-834f-11ee-b962-0242ac120002',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class CategoriesCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'categories',
      apiUrl: 'http://tmztoolsdev:3000/categories/',
      callType: ApiCallType.get,
      headers: {
        'apiKey': 'ec2d2742-834f-11ee-b962-0242ac120002',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
