import 'package:get/get.dart';
import 'package:portfolio/Model/board_model.dart';
import 'package:portfolio/Model/common_result_model.dart';
import 'package:portfolio/Model/pageable_model.dart';
import 'package:portfolio/Service/board_service.dart';

class BoardController extends GetxController {
  var boardPosts = List<Board>.from([]).obs;

  var page = 0.obs;
  var size = 12.obs;
  var totalPages = 0.obs;

  var focusedRowHandle = (-1).obs;

  BoardService service = BoardService();

  /// 게시글 불러오기
  getBoardPage(Pageable pageable) async {
    var result = await service.getBoardPage(pageable);

    totalPages.value = result.totalPages;
    boardPosts.value = result.data;
  }

  /// 게시글 상세보기
  Future<Board?> getBoardDetail(String boardId) async {
    var result = await service.getBoardDetail(boardId);

    return result;
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

  Future<CommonResultModel> saveBoard(Board board) async {
    CommonResultModel result = await service.setBoard(board);

    return result;
  }

  void setFocusedRowHandle(int _focusedRowHandle) {
    focusedRowHandle.value = _focusedRowHandle;
  }
}
