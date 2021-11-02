import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:portfolio/Model/about_model.dart';
import 'package:portfolio/Model/common_result_model.dart';
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

        if (jsonResponse["success"]) {
          return new AboutModel.fromJson(jsonResponse["data"]);
        } else {
          return new AboutModel();
        }
      } else {
        return new AboutModel();
      }
    } on TimeoutException catch (_) {
      return new AboutModel();
    } on Exception catch (_) {
      return new AboutModel();
    }
  }

  ///소개정보 저장
  Future<CommonResultModel> setAboutInfo(AboutModel about) async {
    try {
      final response = await http.post(Uri.parse(config.baseURL + "/aboutInfo/save"),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: convert.jsonEncode(about));

      if (response.statusCode == 200) {
        var responseBody = convert.utf8.decode(response.bodyBytes);
        Map<String, dynamic> jsonResponse = convert.jsonDecode(responseBody);
        return new CommonResultModel.fromJson(jsonResponse);
      } else {
        return new CommonResultModel(msg: response.statusCode.toString() + "error !");
      }
    } on TimeoutException catch (_) {
      return new CommonResultModel(msg: "API 응답 시간을 초과했습니다.");
    }
  }
}
