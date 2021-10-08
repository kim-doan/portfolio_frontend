import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:portfolio/Model/about_model.dart';
import 'dart:convert' as convert;

import 'package:portfolio/app_config.dart';

class AboutService {
  var config = AppConfig();

  ///소개정보 조회
  Future<AboutModel> getAboutInfo() async {
    try {
      final response = await http.get(Uri.parse(config.baseURL + "/aboutInfo"));

      if (response.statusCode == 200) {
        var responseBody = convert.utf8.decode(response.bodyBytes);
        Map<String, dynamic> jsonResponse = convert.jsonDecode(responseBody);

        return new AboutModel.fromJson(jsonResponse["data"]);
      } else {
        return new AboutModel();
      }
    } on TimeoutException catch (_) {
      return new AboutModel();
    }
  }
}
