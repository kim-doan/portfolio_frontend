import 'package:get/get.dart';

class UIController extends GetxController {
  var pageIndex = 0.obs;

  void setPageIndex(_pageIndex) {
    pageIndex.value = _pageIndex;
  }
}
