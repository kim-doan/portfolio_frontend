import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:portfolio/Model/board_model.dart';
import 'package:portfolio/Model/common_result_model.dart';
import 'package:portfolio/Model/pageable_model.dart';
import 'dart:convert' as convert;

import 'package:portfolio/app_config.dart';

class BoardService {
  var config = AppConfig();

  ///게시글 정보 불러오기
  Future<BoardModel> getBoardPage(Pageable pageable) async {
    try {
      final response = await http.get(Uri.parse(
          config.baseURL + "/board/page?page=" + pageable.page.toString() + "&size=" + pageable.size.toString()));

      if (response.statusCode == 200) {
        var responseBody = convert.utf8.decode(response.bodyBytes);
        Map<String, dynamic> jsonResponse = convert.jsonDecode(responseBody);

        return new BoardModel.fromJson(jsonResponse);
      } else {
        return new BoardModel(success: false, code: response.statusCode.toString(), msg: response.body);
      }
    } on TimeoutException catch (_) {
      return new BoardModel(success: false, msg: "API 요청시간을 초과했습니다.");
    }
  }

  ///게시글 상세정보
  Future<Board?> getBoardDetail(String boardId) async {
    try {
      final response = await http.get(Uri.parse(config.baseURL + "/board?boardId=" + boardId));

      if (response.statusCode == 200) {
        var responseBody = convert.utf8.decode(response.bodyBytes);
        Map<String, dynamic> jsonResponse = convert.jsonDecode(responseBody);

        if (jsonResponse["success"] == true) {
          return new Board.fromJson(jsonResponse["data"]);
        }
      }
    } on TimeoutException catch (_) {
      return null;
    }
  }

  ///게시글 저장
  Future<CommonResultModel> setBoard(Board board) async {
    try {
      final response = await http.post(Uri.parse(config.baseURL + "/board/save"),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: convert.jsonEncode(board));

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
