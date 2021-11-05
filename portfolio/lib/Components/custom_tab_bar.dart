import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/Controller/ui_controller.dart';

class CustomTabBar extends StatelessWidget {
  CustomTabBar({required this.controller, required this.tabs});

  final TabController controller;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    var uiController = Get.put(UIController());
    double screenWidth = MediaQuery.of(context).size.width;
    double tabBarScaling = screenWidth > 1400
        ? 0.2
        : screenWidth > 1100
            ? 0.3
            : 0.4;
    return Padding(
      padding: EdgeInsets.only(right: screenWidth * 0.01),
      child: Container(
        width: screenWidth * tabBarScaling,
        child: Theme(
          data: ThemeData(
              highlightColor: Colors.transparent, splashColor: Colors.transparent, hoverColor: Colors.transparent),
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            controller: controller,
            indicatorColor: Color(0xff21a179),
            onTap: (value) {
              uiController.setPageIndex(value);
            },
            tabs: tabs,
          ),
        ),
      ),
    );
  }
}
