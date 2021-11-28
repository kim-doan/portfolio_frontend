import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:portfolio/Controller/about_controller.dart';
import 'package:portfolio/Controller/loading_controller.dart';
import 'package:portfolio/Model/about_model.dart';

class StackInfo extends StatefulWidget {
  const StackInfo({Key? key}) : super(key: key);

  @override
  _StackInfoState createState() => _StackInfoState();
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(<K, List<E>>{},
      (Map<K, List<E>> map, E element) => map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

class _StackInfoState extends State<StackInfo> {
  var loadingController = Get.put(LoadingController());
  var aboutController = Get.put(AboutController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      // height: size.height,
      child: Padding(
        padding: size.width > 710
            ? const EdgeInsets.only(top: 30, bottom: 30, left: 50, right: 50)
            : const EdgeInsets.all(1),
        child: Obx(() {
          return Container(
            child: buildStackRow("주요스킬", aboutController.about.value.stackList),
          );
        }),
      ),
    );
  }

  Widget buildStackRow(String title, List<TechStack> stackList) {
    Size size = MediaQuery.of(context).size;

    var stackMap = stackList
        .map((a) => {
              "stackCtg": a.stackCtg,
              "stackName": a.stackName,
              "icon": a.icon,
              "stackGuage": a.stackGuage,
              "enabled": a.enabled
            })
        .toList();

    var stackCtgMap = stackMap.groupBy((m) => m["stackCtg"]);

    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: stackCtgMap.keys
            .map((k) => Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: size.width > 715 ? 110 : 80,
                          padding: EdgeInsets.only(bottom: 8, left: 2),
                          decoration:
                              BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey.shade500))),
                          child: Text(
                            k.toString(),
                            style: TextStyle(fontSize: size.width > 1000 ? 19 : 14, color: Color(0xFF2278bd)),
                          ),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                    Column(
                      children: stackCtgMap[k]!
                          .map((e) => Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    child: (e['icon'] == null || e['icon'].toString() == "")
                                        ? new Container()
                                        : Image.memory(Base64Decoder().convert(e['icon'].toString())),
                                  ),
                                  Text(
                                    e['stackName'].toString(),
                                    style: TextStyle(fontSize: size.width > 1000 ? 19 : 14, color: Colors.white),
                                  ),
                                  SizedBox(width: 30),
                                  Container(
                                    width: 100,
                                    height: 15,
                                    child: FAProgressBar(
                                      currentValue: int.tryParse(e['stackGuage'].toString()) ?? 0,
                                      backgroundColor: Color(0XFF2278bd).withOpacity(0.4),
                                      progressColor: Color(0XFF2278bd),
                                      animatedDuration: Duration(milliseconds: 2000),
                                    ),
                                  ),
                                ],
                              ))
                          .toList(),
                    )
                  ],
                ))
            .toList());

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   width: size.width > 715 ? 110 : 80,
        //   padding: EdgeInsets.only(bottom: 8, left: 2),
        //   decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey.shade500))),
        //   child: Text(
        //     title,
        //     style: TextStyle(fontSize: size.width > 1000 ? 19 : 14, color: Color(0xFF2278bd)),
        //   ),
        // ),
        // SizedBox(width: 40),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: stackList
                .map((stack) => Row(
                      children: [
                        Container(
                          width: size.width > 715 ? 110 : 80,
                          padding: EdgeInsets.only(bottom: 8, left: 2),
                          decoration:
                              BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.grey.shade500))),
                          child: Text(
                            title,
                            style: TextStyle(fontSize: size.width > 1000 ? 19 : 14, color: Color(0xFF2278bd)),
                          ),
                        ),
                        SizedBox(width: 40),
                        Container(
                          width: 30,
                          height: 30,
                          child: (stack.icon == null || stack.icon == "")
                              ? new Container()
                              : Image.memory(Base64Decoder().convert(stack.icon!)),
                        ),
                        Text(
                          stack.stackName,
                          style: TextStyle(fontSize: size.width > 1000 ? 19 : 14, color: Colors.white),
                        ),
                        SizedBox(width: 30),
                        Container(
                          width: 100,
                          height: 15,
                          child: FAProgressBar(
                            currentValue: stack.stackGuage,
                            backgroundColor: Color(0XFF2278bd).withOpacity(0.4),
                            progressColor: Color(0XFF2278bd),
                            animatedDuration: Duration(milliseconds: 2000),
                          ),
                        ),
                      ],
                    ))
                .toList()),
      ],
    );
  }
}
