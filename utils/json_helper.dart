import 'dart:convert';

class JsonHelper {
  static String encode(dynamic data) {
    return jsonEncode(data);
  }

  static dynamic decode(String json) {
    return jsonDecode(json);
  }
}