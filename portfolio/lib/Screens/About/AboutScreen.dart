import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/Controller/about_controller.dart';
import 'package:portfolio/Model/about_model.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  var aboutController = Get.put(AboutController());

  @override
  void initState() {
    super.initState();

    aboutController.getAboutInfo();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (size.width > 1300)
            Container(
              alignment: Alignment.center,
              // color: Colors.white,
              width: size.width * 0.5,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "만나서",
                    style: TextStyle(fontSize: 70, color: Color(0xFF076799), fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "반갑습니다.",
                    style: TextStyle(fontSize: 70, color: Color(0xFF3F3F3F), fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "김도안입니다.",
                    style: TextStyle(fontSize: 70, color: Color(0xFFB3B3B3), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          Container(
            width: size.width > 1315 ? size.width * 0.5 : size.width,
            height: size.height,
            child: Padding(
              padding: size.width > 710
                  ? const EdgeInsets.only(top: 100, bottom: 100, left: 50, right: 50)
                  : const EdgeInsets.all(1),
              child: Container(
                // color: Colors.white,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Obx(() {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildRow("이름", aboutController.about.value.name),
                        SizedBox(height: 20),
                        buildRow("이메일", aboutController.about.value.email),
                        SizedBox(height: 20),
                        buildRow("핸드폰", aboutController.about.value.phoneNo),
                        SizedBox(height: 20),
                        buildRow("총 경력", aboutController.about.value.career.toString()),
                        SizedBox(height: 20),
                        buildDynamicRow("경력사항", aboutController.about.value.careerList),
                        SizedBox(height: 20),
                        buildDynamicRow("주요프로젝트", aboutController.about.value.projectList),
                        SizedBox(height: 20),
                      ],
                    );
                  }),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildRow(String title, String content) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        Container(
          width: size.width > 900 ? 110 : 80,
          padding: EdgeInsets.only(bottom: 8, left: 2),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey.shade500))),
          child: Text(
            title,
            style: TextStyle(fontSize: size.width > 1000 ? 20.sp : 14, color: Color(0xFF2278bd)),
          ),
        ),
        SizedBox(width: 40.w),
        Text(content, style: TextStyle(fontSize: size.width > 1000 ? 20.sp : 14, color: Colors.white)),
      ],
    );
  }

  Widget buildDynamicRow(String title, List<AboutDetail> contents) {
    Size size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: size.width > 715 ? 110 : 80,
          padding: EdgeInsets.only(bottom: 8, left: 2),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey.shade500))),
          child: Text(
            title,
            style: TextStyle(fontSize: size.width > 1000 ? 20.sp : 14, color: Color(0xFF2278bd)),
          ),
        ),
        SizedBox(width: 40.w),
        Row(
          children: [
            if (size.width > 500)
              new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: contents
                      .map((content) => Column(
                            children: [
                              new Text(
                                  DateFormat("yyyy-MM-dd").format(content.startDate!) +
                                      " ~ " +
                                      ((content.endDate == null)
                                          ? "      현재       "
                                          : DateFormat("yyyy-MM-dd").format(content.endDate!)) +
                                      " | ",
                                  style: TextStyle(fontSize: size.width > 1000 ? 20.sp : 14, color: Colors.grey[400])),
                              SizedBox(height: 15),
                            ],
                          ))
                      .toList()),
            new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: contents
                    .map((content) => Column(
                          children: [
                            new Text(content.contents,
                                style: TextStyle(fontSize: size.width > 1000 ? 20.sp : 14, color: Colors.white)),
                            SizedBox(height: 15),
                          ],
                        ))
                    .toList()),
          ],
        )
        // Text(content, style: TextStyle(fontSize: 16, color: Colors.white)),
      ],
    );
  }
}
