import 'package:get/get.dart';
import 'package:portfolio/Model/board_model.dart';
import 'package:portfolio/Model/pageable_model.dart';
import 'package:portfolio/Service/board_service.dart';

class BoardController extends GetxController {
  var boardPosts = List<BoardModel>.from([]).obs;

  var page = 0.obs;
  var size = 10.obs;

  BoardService service = BoardService();

  /// 게시글 불러오기
  getBoardPage() async {
    var result = await service.getBoardPage(Pageable(page: page.value, size: size.value));

    boardPosts.value = result;
  }
}
