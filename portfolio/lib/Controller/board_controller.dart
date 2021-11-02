import 'package:get/get.dart';
import 'package:portfolio/Model/board_model.dart';
import 'package:portfolio/Model/pageable_model.dart';
import 'package:portfolio/Service/board_service.dart';

class BoardController extends GetxController {
  var boardPosts = List<Board>.from([]).obs;

  var boardParam = Board().obs;

  var page = 0.obs;
  var size = 12.obs;
  var totalPages = 0.obs;

  var focusedRowHandle = 0.obs;

  BoardService service = BoardService();

  /// 게시글 불러오기
  getBoardPage(Pageable pageable) async {
    var result = await service.getBoardPage(pageable);

    totalPages.value = result.totalPages;
    boardPosts.value = result.data;
  }

  /// 게시글 다음페이지
  nextBoardPage() async {
    if (page.value <= totalPages.value) {
      page.value = page.value + 1;
      var result = await service.getBoardPage(Pageable(page: page.value, size: size.value));

      totalPages.value = result.totalPages;
      boardPosts.addAll(result.data);
    }
  }

  saveBoard(Board board) async {
    boardParam.value = board;
    service.setBoard(boardParam.value);
  }

  void setFocusedRowHandle(int _focusedRowHandle) {
    focusedRowHandle.value = _focusedRowHandle;
  }
}
