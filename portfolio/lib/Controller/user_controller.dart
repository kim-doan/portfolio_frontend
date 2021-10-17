import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:portfolio/Model/common_result_model.dart';
import 'package:portfolio/Model/login_session_model.dart';
import 'package:portfolio/Model/pageable_model.dart';
import 'package:portfolio/Model/profile_model.dart';
import 'package:portfolio/Service/user_service.dart';

class UserController extends GetxController {
  var loginSession = LoginSessionModel().obs; // 로그인 상태 정보
  var profile = Profile().obs; // 로그인한 사용자의 프로필
  var registerState = CommonResultModel().obs; // 회원가입 상태정보
  var userList = List<Profile>.from([]).obs; // 유저 전체정보

  var totalPages = 0.obs;

  UserService service = UserService();

  /// 로그인
  doLogin(Map<String, dynamic> param) async {
    var result = await service.login(param);

    if (result != null) {
      loginSession.value = result;
    } else {
      doLogout();
    }
  }

  /// 로그아웃
  doLogout() {
    GetStorage().remove("authToken");
    profile.value = new Profile();
  }

  /// 접속자 프로필 (토큰인증)
  validToken(String token) async {
    var result = await service.validToken(token);

    if (result != null) {
      profile.value = result;

      GetStorage().write("authToken", token);
    } else {
      GetStorage().remove("authToken");
    }
  }

  ///회원가입
  register(Map<String, dynamic> param) async {
    var result = await service.register(param);

    registerState.value = result;
  }

  ///유저정보 전체 조회
  getUserAll(Pageable pageable) async {
    var result = await service.getUserAll(pageable);

    totalPages.value = result.totalPages;
    userList.value = result.data;
  }
}
