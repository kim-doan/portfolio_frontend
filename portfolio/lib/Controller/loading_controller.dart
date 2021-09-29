import 'package:get/get.dart';

class LoadingController extends GetxController {
  var isLoading = false.obs;
  var text = "".obs;

  void show(bool _isLoading, String _text) {
    isLoading.value = _isLoading;
    text.value = _text;
  }

  void hide() {
    isLoading.value = false;
    text.value = "";
  }
}
