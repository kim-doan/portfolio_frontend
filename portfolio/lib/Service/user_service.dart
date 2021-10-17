import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:portfolio/Model/common_result_model.dart';
import 'package:portfolio/Model/login_session_model.dart';
import 'package:portfolio/Model/pageable_model.dart';
import 'package:portfolio/Model/profile_model.dart';
import 'dart:convert' as convert;

import 'package:portfolio/app_config.dart';

class UserService {
  var config = AppConfig();

  //로그인
  Future<LoginSessionModel?> login(Map<String, dynamic> params) async {
    try {
      final response = await http.post(Uri.parse(config.baseURL + "/signIn"),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: convert.jsonEncode(params));

      if (response.statusCode == 200) {
        var responseBody = convert.utf8.decode(response.bodyBytes);
        Map<String, dynamic> jsonResponse = convert.jsonDecode(responseBody);
        return new LoginSessionModel.fromJson(jsonResponse);
      }
    } on TimeoutException catch (_) {
      print("respose time out");
    }
  }

  //로그인 토큰 확인
  Future<Profile?> validToken(String token) async {
    try {
      final response = await http.get(Uri.parse(config.baseURL + "/profile"), headers: {"X-AUTH-TOKEN": token});

      if (response.statusCode == 200) {
        var responseBody = convert.utf8.decode(response.bodyBytes);

        if (responseBody.isEmpty == true) {
          return null;
        }

        Map<String, dynamic> jsonResponse = convert.jsonDecode(responseBody);

        if (jsonResponse['success']) {
          return new Profile.fromJson(jsonResponse['data']);
        } else {
          return null;
        }
      }
    } on TimeoutException catch (_) {
      print("response time out");
    }
  }

  //회원가입
  Future<CommonResultModel> register(Map<String, dynamic> params) async {
    try {
      final response = await http.post(Uri.parse(config.baseURL + "/signUp"),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: convert.jsonEncode(params));

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

  ///유저정보 전체 조회
  Future<ProfileModel> getUserAll(Pageable pageable) async {
    try {
      final response = await http.get(Uri.parse(
          config.baseURL + "/userAll?page=" + pageable.page.toString() + "&size=" + pageable.size.toString()));

      if (response.statusCode == 200) {
        var responseBody = convert.utf8.decode(response.bodyBytes);
        Map<String, dynamic> jsonResponse = convert.jsonDecode(responseBody);

        return new ProfileModel.fromJson(jsonResponse);
      } else {
        return new ProfileModel();
      }
    } on TimeoutException catch (_) {
      return new ProfileModel();
    }
  }
}
