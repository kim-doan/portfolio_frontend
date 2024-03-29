import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/Components/date_between.dart';
import 'package:portfolio/Controller/about_controller.dart';
import 'package:portfolio/Model/about_model.dart';
import 'package:portfolio/Model/common_result_model.dart';

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

  PickedFile? _image;

  @override
  void initState() {
    super.initState();
    aboutController.getAboutInfo();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
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
            buildDynamicRow("경력사항", aboutController.about.value.careerList),
            SizedBox(height: 40),
            buildDynamicRow("프로젝트", aboutController.about.value.projectList),
            SizedBox(height: 40),
            buildStackRow("사용기술", aboutController.about.value.stackList),
            SizedBox(height: 40),
            Center(
              child: Container(
                width: 800,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    CommonResultModel result = await aboutController.setAboutInfo();

                    if (result.success) {
                      Fluttertoast.showToast(
                          msg: "변경사항을 저장했습니다.",
                          backgroundColor: Colors.black,
                          webPosition: "center",
                          webBgColor: "#21a366",
                          timeInSecForIosWeb: 3,
                          textColor: Colors.white);
                    } else {
                      Fluttertoast.showToast(
                          msg: result.msg ?? "",
                          backgroundColor: Colors.black,
                          webPosition: "center",
                          webBgColor: "#ea4335",
                          timeInSecForIosWeb: 3,
                          textColor: Colors.white);
                    }
                  },
                  icon: Icon(Icons.save),
                  label: Text("변경사항 저장"),
                  style: ElevatedButton.styleFrom(primary: Colors.green[500]),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildRow(String title, String content, TextEditingController controller) {
    Size size = MediaQuery.of(context).size;

    controller.text = content;

    return Container(
      width: 500,
      child: Row(
        children: [
          Container(
            width: 100,
            padding: EdgeInsets.only(bottom: 8, left: 2),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, color: Color(0xFF2196f3)),
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
            ),
            onChanged: (value) {
              aboutController.setPrimaryAbout(
                  nameController.text, emailController.text, phoneController.text, careerController.text);
            },
          )),
        ],
      ),
    );
  }

  Widget buildStackRow(String title, List<TechStack> contents) {
    return Container(
      width: 800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            padding: EdgeInsets.only(bottom: 8, left: 2),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, color: Color(0xFF2196F3)),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              children: [
                Column(
                    children: contents
                        .asMap()
                        .entries
                        .map(
                          (entry) => (entry.value.enabled == false)
                              ? new Container()
                              : Column(key: Key(entry.key.toString()), children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                            width: 50,
                                            height: 50,
                                            color: Colors.white,
                                            child: Center(
                                                child: (entry.value.icon == null || entry.value.icon == "")
                                                    ? Icon(Icons.image_not_supported)
                                                    : Image.memory(Base64Decoder().convert(entry.value.icon!)))),
                                      ),
                                      SizedBox(width: 20.w),
                                      Expanded(
                                        flex: 3,
                                        child: TextFormField(
                                          initialValue: entry.value.stackCtg,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            filled: true,
                                            hintText: "카테고리",
                                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                            enabledBorder:
                                                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                            fillColor: Colors.white,
                                            focusColor: Colors.white,
                                          ),
                                          onChanged: (value) {
                                            aboutController.stackCtgController(entry.key, value);
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        flex: 4,
                                        child: TextFormField(
                                          initialValue: entry.value.stackName,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            filled: true,
                                            hintText: title,
                                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                            enabledBorder:
                                                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                            fillColor: Colors.white,
                                            focusColor: Colors.white,
                                          ),
                                          onChanged: (value) {
                                            aboutController.stackNameController(entry.key, value);
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        flex: 2,
                                        child: TextFormField(
                                          initialValue: entry.value.stackGuage.toString(),
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            filled: true,
                                            hintText: "숙련도(%)",
                                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                            enabledBorder:
                                                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                            fillColor: Colors.white,
                                            focusColor: Colors.white,
                                          ),
                                          onChanged: (value) {
                                            aboutController.stackGuageController(entry.key, value);
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.red[400],
                                          child: IconButton(
                                              onPressed: () {
                                                aboutController.delStackList(entry.key);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 24,
                                              ))),
                                      SizedBox(width: 5.w),
                                      Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.green[400],
                                          child: IconButton(
                                              onPressed: () async {
                                                FilePickerResult? result = await FilePicker.platform.pickFiles();

                                                if (result == null) return;

                                                Uint8List? bytes = result.files.single.bytes;

                                                aboutController.stackIconController(entry.key, base64Encode(bytes!));
                                              },
                                              icon: Icon(
                                                Icons.file_upload,
                                                color: Colors.white,
                                              )))
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ]),
                        )
                        .toList()),
                Container(
                    width: 800,
                    height: 50,
                    color: Color(0XFF2196F3),
                    child: IconButton(
                        onPressed: () {
                          aboutController.addTechStack();
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        )))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildDynamicRow(String title, List<AboutDetail> contents) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: 800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            padding: EdgeInsets.only(bottom: 8, left: 2),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, color: Color(0xFF2196f3)),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              children: [
                Column(
                  children: contents
                      .asMap()
                      .entries
                      .map((entry) => (entry.value.enabled == false)
                          ? new Container()
                          : Column(
                              key: Key(entry.key.toString()),
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: DateBetween(
                                        title: "",
                                        initialValue: entry.value.startDate != null
                                            ? DateFormat("yyyy-MM-dd").format(entry.value.startDate!)
                                            : "",
                                        initialValue2: entry.value.endDate != null
                                            ? DateFormat("yyyy-MM-dd").format(entry.value.endDate!)
                                            : "",
                                        hintText1: "yyyy-MM-dd",
                                        hintText2: "yyyy-MM-dd",
                                        onChanged: (value) {
                                          if (DateTime.tryParse(value) != null) {
                                            aboutController.startDateController(
                                                title, entry.key, DateTime.parse(value));
                                          }
                                        },
                                        onChanged2: (value) {
                                          if (DateTime.tryParse(value) != null) {
                                            aboutController.endDateController(title, entry.key, DateTime.parse(value));
                                          } else {
                                            aboutController.endDateController(title, entry.key, null);
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                    Expanded(
                                      child: TextFormField(
                                        initialValue: entry.value.contents,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          filled: true,
                                          hintText: title,
                                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                                          enabledBorder:
                                              OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                          fillColor: Colors.white,
                                          focusColor: Colors.white,
                                        ),
                                        onChanged: (value) {
                                          aboutController.contentsController(title, entry.key, value);
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Container(
                                        width: 50,
                                        height: 50,
                                        color: Colors.red[400],
                                        child: IconButton(
                                            onPressed: () {
                                              aboutController.delAboutDetail(title, entry.key);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 24,
                                            )))
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ))
                      .toList(),
                ),
                Container(
                    width: 800,
                    height: 50,
                    color: Color(0XFF2196F3),
                    child: IconButton(
                        onPressed: () {
                          aboutController.addAboutDetail(title);
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
