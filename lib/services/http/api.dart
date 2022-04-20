import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:laxia/models/res_model.dart';
import 'package:laxia/utils/preference_util.dart';

class Api {
  final apiUrl = dotenv.env["DEV_API_URL"];

  final PreferenceUtil preferenceUtil = PreferenceUtil();

  static Future<ResObj> get(String url, String? token) async {
    try {
      final res = await http.get(Uri.parse(url), headers: {
        "Authorization": token ?? "",
      });
      if (res.statusCode == 200) {
        final dynamic jsonMap = json.decode(res.body);

        return ResObj(status: true, code: res.statusCode, data: jsonMap);
      } else {
        return ResObj(status: false, code: res.statusCode, error: res.body);
      }
    } catch (e) {
      return ResObj(status: false, error: "unknown");
    }
  }

  static Future<ResObj?> post(
      String url, Map<String, String> data, String? token) async {
    try {
      var request = new http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        "Authorization": token ?? "",
        "Content-Type": "multipart/form-data"
      });

      data.forEach((key, value) {
        request.fields[key] = value;
      });
      var streamResponse = await request.send();
      print(streamResponse);
      final responseString = await streamResponse.stream.bytesToString();

      if (streamResponse.statusCode == 200) {
        final dynamic jsonMap = json.decode(responseString);
        return ResObj(
            status: true, code: streamResponse.statusCode, data: jsonMap);
      } else {
        return ResObj(
            status: false, code: streamResponse.statusCode, error: "error");
      }
    } catch (e) {
      print(e);
      return ResObj(status: false, error: "unknown");
    }
  }

  static Future<ResObj> put(
      String url, Map<String, String> data, String? token) async {
    try {
      final res = await http.put(Uri.parse(url),
          body: json.encode(data),
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization": token != null ? 'Bearer $token' : '',
          });
      if (res.statusCode == 200) {
        final dynamic jsonMap = json.decode(res.body);

        return ResObj(status: true, code: res.statusCode, data: jsonMap);
      } else {
        return ResObj(status: false, code: res.statusCode, error: res.body);
      }
    } catch (e) {
      return ResObj(status: false, error: "unknown");
    }
  }
}
