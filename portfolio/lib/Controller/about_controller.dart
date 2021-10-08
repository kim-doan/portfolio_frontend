import 'dart:convert';
import 'package:get/get.dart';
import 'package:portfolio/Model/about_model.dart';
import 'package:portfolio/Service/about_service.dart';

class AboutController extends GetxController {
  var about = AboutModel().obs;

  AboutService service = AboutService();

  ///소개 정보 조회
  getAboutInfo() async {
    var result = await service.getAboutInfo();

    about.value = result;
  }

  addCareer() {
    AboutModel tempAbout = about.value.copyWith();

    // List<AboutDetail> temp1 = tempAbout.careerList;

    // temp1.add(new AboutDetail());

    tempAbout.careerList = List<AboutDetail>.from([]);

    // tempAbout.name = "1";

    about.value = tempAbout;

    // List<AboutDetail> careerList = about.value.careerList;

    // careerList.add(new AboutDetail());

    // about.value.name = "1";

    // about.value.careerList = careerList;
    // about.value = new AboutModel();
  }
}
