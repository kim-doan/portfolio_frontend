import 'package:get/get.dart';
import 'package:portfolio/Model/about_model.dart';
import 'package:portfolio/Model/common_result_model.dart';
import 'package:portfolio/Service/about_service.dart';

class AboutController extends GetxController {
  var about = AboutModel().obs;

  AboutService service = AboutService();

  ///소개 정보 조회
  getAboutInfo() async {
    var result = await service.getAboutInfo();

    about.value = result;
  }

  //소개 정보 저장
  Future<CommonResultModel> setAboutInfo() async {
    AboutModel paramAbout = about.value.copyWith();

    paramAbout.careerList = paramAbout.careerList.where((element) => element.enabled == true).toList();
    paramAbout.projectList = paramAbout.projectList.where((element) => element.enabled == true).toList();
    paramAbout.stackList = paramAbout.stackList.where((element) => element.enabled == true).toList();

    var result = await service.setAboutInfo(paramAbout);

    return result;
  }

  setPrimaryAbout(String name, String email, String phoneNo, String career) {
    about.value.name = name;
    about.value.email = email;
    about.value.phoneNo = phoneNo;
    about.value.career = int.tryParse(career) ?? 0;
  }

  addAboutDetail(String type) {
    AboutModel tempAbout = about.value.copyWith();

    switch (type) {
      case "경력사항":
        tempAbout.careerList.add(new AboutDetail());
        break;
      case "프로젝트":
        tempAbout.projectList.add(new AboutDetail());
        break;
    }

    about.value = tempAbout;
  }

  addTechStack() {
    AboutModel tempAbout = about.value.copyWith();

    tempAbout.stackList.add(new TechStack());

    about.value = tempAbout;
  }

  delAboutDetail(String type, int index) {
    AboutModel tempAbout = about.value.copyWith();

    switch (type) {
      case "경력사항":
        tempAbout.careerList[index].enabled = false;
        break;
      case "프로젝트":
        tempAbout.projectList[index].enabled = false;
        break;
    }

    about.value = tempAbout;
  }

  delStackList(int index) {
    AboutModel tempAbout = about.value.copyWith();

    tempAbout.stackList[index].enabled = false;

    about.value = tempAbout;
  }

  startDateController(String type, int index, DateTime value) {
    AboutModel tempAbout = about.value.copyWith();

    switch (type) {
      case "경력사항":
        tempAbout.careerList[index].startDate = value;
        break;
      case "프로젝트":
        tempAbout.projectList[index].startDate = value;
        break;
    }

    about.value = tempAbout;
  }

  endDateController(String type, int index, DateTime? value) {
    AboutModel tempAbout = about.value.copyWith();

    switch (type) {
      case "경력사항":
        tempAbout.careerList[index].endDate = value;
        break;
      case "프로젝트":
        tempAbout.projectList[index].endDate = value;
        break;
    }

    about.value = tempAbout;
  }

  contentsController(String type, int index, String value) {
    AboutModel tempAbout = about.value.copyWith();

    switch (type) {
      case "경력사항":
        tempAbout.careerList[index].contents = value;
        break;
      case "프로젝트":
        tempAbout.projectList[index].contents = value;
        break;
    }

    about.value = tempAbout;
  }

  stackCtgController(int index, String value) {
    AboutModel tempAbout = about.value.copyWith();

    tempAbout.stackList[index].stackCtg = value;

    about.value = tempAbout;
  }

  stackNameController(int index, String value) {
    AboutModel tempAbout = about.value.copyWith();

    tempAbout.stackList[index].stackName = value;

    about.value = tempAbout;
  }

  stackGuageController(int index, String value) {
    AboutModel tempAbout = about.value.copyWith();

    tempAbout.stackList[index].stackGuage = int.tryParse(value) ?? 0;

    about.value = tempAbout;
  }

  stackIconController(int index, String value) {
    AboutModel tempAbout = about.value.copyWith();

    tempAbout.stackList[index].icon = value;

    about.value = tempAbout;
  }
}
