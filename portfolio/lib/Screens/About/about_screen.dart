import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/Controller/about_controller.dart';
import 'package:portfolio/Controller/loading_controller.dart';
import 'package:portfolio/Screens/About/about_info.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  var loadingController = Get.put(LoadingController());
  var aboutController = Get.put(AboutController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (size.width > 1692)
            Container(
              alignment: Alignment.center,
              width: size.width * 0.5,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "만나서",
                    style: TextStyle(fontSize: 70, color: Color(0xFF7D7D7D), fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "반갑습니다.",
                    style: TextStyle(fontSize: 70, color: Color(0xFFB7B7B7), fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "김도안입니다.",
                    style: TextStyle(fontSize: 70, color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          AboutInfo()
        ],
      ),
    );
  }
}
