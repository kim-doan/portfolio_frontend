import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/Controller/about_controller.dart';
import 'package:portfolio/Controller/loading_controller.dart';
import 'package:portfolio/Screens/About/about_info.dart';
import 'package:portfolio/Screens/About/stack_info.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  var loadingController = Get.put(LoadingController());
  var aboutController = Get.put(AboutController());

  final List<Widget> introViews = [
    AboutInfo(),
    StackInfo(),
  ];
  List<bool> isSelected = [true, false];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      loadingController.show(true, "");
      await aboutController.getAboutInfo();
      loadingController.hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    ItemScrollController itemScrollController = ItemScrollController();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (size.width > 1250)
            Container(
              alignment: Alignment.center,
              width: (size.width > 1650) ? size.width * 0.5 : size.width * 0.35,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "만나서",
                    style: TextStyle(fontSize: 70, color: Color(0xFF7D7D7D), fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "반갑습니다.",
                    style: TextStyle(fontSize: 70, color: Color(0xFFB7B7B7), fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "김도안입니다.",
                    style: TextStyle(fontSize: 70, color: Color(0xFFFFFFFF), fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: size.width > 710
                        ? const EdgeInsets.only(top: 30, bottom: 30, left: 50, right: 50)
                        : const EdgeInsets.all(1),
                    child: ToggleButtons(
                      color: Colors.white.withOpacity(0.4),
                      selectedColor: Colors.white,
                      // hoverColor: Color(0xFF6200EE).withOpacity(0.04),
                      borderColor: Colors.white.withOpacity(0.4),
                      selectedBorderColor: Colors.white,
                      fillColor: Color(0xFF6200EE).withOpacity(0),
                      splashColor: Color(0xFF6200EE).withOpacity(0),
                      // borderRadius: BorderRadius.only(bottomLeft: Radius.zero),
                      borderWidth: 2,
                      constraints: BoxConstraints(minHeight: 36.0),
                      isSelected: isSelected,
                      onPressed: (int newIndex) {
                        setState(() {
                          for (int index = 0; index < isSelected.length; index++) {
                            if (index == newIndex) {
                              isSelected[index] = true;
                            } else {
                              isSelected[index] = false;
                            }

                            itemScrollController.scrollTo(index: newIndex, duration: Duration(milliseconds: 150));
                          }
                        });
                      },
                      children: [
                        SizedBox(
                          width: (size.width > 1250) ? size.width * 0.1 : size.width * 0.25,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '경력사항',
                              style: TextStyle(fontSize: (size.width > 1250) ? 20.sp : 14),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: (size.width > 1250) ? size.width * 0.1 : size.width * 0.25,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '주요기술',
                              style: TextStyle(fontSize: (size.width > 1250) ? 20.sp : 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: Container(
                      width: size.width,
                      height: size.height,
                      child: ScrollablePositionedList.builder(
                        scrollDirection: Axis.horizontal,
                        itemScrollController: itemScrollController,
                        itemCount: introViews.length,
                        itemBuilder: (context, index) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            introViews[index],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // AboutInfo()
        ],
      ),
    );
  }
}
