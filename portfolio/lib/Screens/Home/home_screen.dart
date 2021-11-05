import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height - 200,
      alignment: Alignment.center,
      margin: EdgeInsets.all(100.w),
      child: Row(
        children: [
          Expanded(
            child: Image.asset(
              "assets/images/doan_logo.png",
              width: ScreenUtil().setWidth(450),
              height: ScreenUtil().setHeight(450),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(100)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "DOAN",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(110),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Portfolio',
                      textStyle: TextStyle(
                        fontSize: ScreenUtil().setSp(100),
                        color: Colors.white,
                      ),
                      speed: const Duration(milliseconds: 250),
                    ),
                  ],
                  totalRepeatCount: 6,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
