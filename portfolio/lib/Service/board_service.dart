import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:portfolio/Model/board_model.dart';
import 'package:portfolio/Model/pageable_model.dart';
import 'dart:convert' as convert;

import 'package:portfolio/app_config.dart';

class BoardService {
  var config = AppConfig();

  ///게시글 정보 불러오기
  Future<List<BoardModel>> getBoardPage(Pageable pageable) async {
    List<BoardModel> list = new List<BoardModel>.from([]);

    try {
      final response = await http.get(Uri.parse(
          config.baseURL + "/board/page?page=" + pageable.page.toString() + "&size=" + pageable.size.toString()));

      if (response.statusCode == 200) {
        var responseBody = convert.utf8.decode(response.bodyBytes);
        Map<String, dynamic> jsonResponse = convert.jsonDecode(responseBody);

        jsonResponse['data'].forEach((v) {
          list.add(BoardModel.fromJson(v));
        });

        return list;
      } else {
        return list;
      }
    } on TimeoutException catch (_) {
      return list;
    }
  }
}
