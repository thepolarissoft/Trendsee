import 'package:trendoapp/utils/storage_utils.dart';

enum HttpMethod { POST, GET, PUT, DELETE }

class IHttpRequest {
  String? absolutePath;
  HttpMethod? httpMethod;
  Map<String, String>? _headers;
  Map<String, String>? _parameters;
  Object? body;

  static Map<String, String> defaultHeader = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization':
        'Bearer ' + StorageUtils.readStringValue(StorageUtils.keyToken),
  };
  Map<String, dynamic>? get headers {
    return _headers;
  }

  Map<String, String?>? get parameters {
    return _parameters;
  }
}
