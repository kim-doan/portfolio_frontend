import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio/Components/custom_icon_button.dart';
import 'package:portfolio/Controller/ui_controller.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var uiController = Get.put(UIController());
    return Column(
      children: [
        Obx(() {
          if (uiController.pageIndex.value > 1)
            return Align(
                alignment: Alignment.center,
                child: Container(
                  height: 2,
                  width: screenWidth * 0.9,
                  color: Colors.white.withOpacity(0.5),
                ));
          else
            return new Container();
        }),
        Container(
          height: screenHeight * 0.05,
          child: Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.05, right: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomIconButton(
                      iconData: FontAwesomeIcons.blog,
                      url: 'https://andokim.tistory.com',
                      color: Colors.red,
                    ),
                    SizedBox(width: screenWidth * 0.021),
                    CustomIconButton(
                      iconData: FontAwesomeIcons.github,
                      url: 'https://github.com/kim-doan',
                      color: Colors.white,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    CustomIconButton(
                      iconData: FontAwesomeIcons.solidCommentDots,
                      url: 'https://open.kakao.com/o/sMeOVaCd',
                      color: Colors.blue,
                    )
                  ],
                ),
                Text('Made with Flutter Web \u00a9 2021', style: TextStyle(color: Colors.white, fontFamily: 'Barlow'))
              ],
            ),
          ),
        )
      ],
    );
  }
}
