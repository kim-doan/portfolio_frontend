import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/Components/date_between.dart';
import 'package:portfolio/Controller/about_controller.dart';
import 'package:portfolio/Model/about_model.dart';

class AboutManage extends StatefulWidget {
  const AboutManage({Key? key}) : super(key: key);

  @override
  _AboutManageState createState() => _AboutManageState();
}

class _AboutManageState extends State<AboutManage> {
  var aboutController = Get.put(AboutController());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController careerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    aboutController.getAboutInfo();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width - 100,
      child: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRow("이름", aboutController.about.value.name, nameController),
            SizedBox(height: 10),
            buildRow("이메일", aboutController.about.value.email, emailController),
            SizedBox(height: 10),
            buildRow("핸드폰", aboutController.about.value.phoneNo, phoneController),
            SizedBox(height: 10),
            buildRow("총 경력", aboutController.about.value.career.toString(), careerController),
            SizedBox(height: 40),
            TextButton(
                onPressed: () {
                  aboutController.addCareer();
                },
                child: Text("추가")),
            buildDynamicRow("경력사항", aboutController.about.value.careerList),
            SizedBox(height: 40),
          ],
        );
      }),
    );
  }

  Widget buildRow(String title, String content, TextEditingController controller) {
    Size size = MediaQuery.of(context).size;

    controller.text = content;

    return Container(
      width: size.width > 1024 ? size.width * 0.5 : size.width,
      child: Row(
        children: [
          Container(
            width: 100,
            padding: EdgeInsets.only(bottom: 8, left: 2),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, color: Color(0xFF2278bd)),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
              child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: title + " 을/를 입력해주세요.",
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                  ))),
        ],
      ),
    );
  }

  Widget buildDynamicRow(String title, List<AboutDetail> contents) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width > 1024 ? size.width * 0.5 : size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            padding: EdgeInsets.only(bottom: 8, left: 2),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, color: Color(0xFF2278bd)),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              children: contents
                  .map((content) => Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DateBetween(
                                  title: "",
                                  initialValue: DateFormat("yyyy-MM-dd").format(content.startDate!),
                                  initialValue2: DateFormat("yyyy-MM-dd").format(content.endDate!),
                                  hintText1: "yyyy-MM",
                                  hintText2: "yyyy-MM",
                                  tap: () {},
                                  tap2: () {},
                                ),
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                  child: TextFormField(
                                      initialValue: content.contents,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        filled: true,
                                        hintText: title,
                                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                        fillColor: Colors.white,
                                        focusColor: Colors.white,
                                      ))),
                            ],
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.add),
          // )
        ],
      ),
    );
  }
}
