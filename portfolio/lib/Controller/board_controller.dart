import 'package:get/get.dart';
import 'package:portfolio/Model/board_model.dart';
import 'package:portfolio/Model/pageable_model.dart';
import 'package:portfolio/Service/board_service.dart';

class BoardController extends GetxController {
  var boardPosts = List<BoardModel>.from([]).obs;

  var page = 0.obs;
  var size = 12.obs;

  BoardService service = BoardService();

  /// 게시글 불러오기
  getBoardPage() async {
    var result = await service.getBoardPage(Pageable(page: 0, size: size.value));

    boardPosts.value = result;
  }

  /// 게시글 다음페이지
  nextBoardPage() async {
    page.value = page.value + 1;

    var result = await service.getBoardPage(Pageable(page: page.value, size: size.value));

    boardPosts.addAll(result);
  }
}
