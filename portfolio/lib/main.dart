import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:portfolio/Controller/user_controller.dart';
import 'package:portfolio/Screens/Main/main_screen.dart';
import 'package:portfolio/constants.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await _validToken();
    });
  }

  _validToken() async {
    var token = GetStorage().read('authToken');

    if (token != null) {
      await userController.validToken(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1920, 1080),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: '김도안 포트폴리오',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Color(0xFF262626),
          fontFamily: 'NanumSquare',
        ),
        home: MainScreen(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          SfGlobalLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('ko', 'KR'),
        ],
        locale: const Locale('ko'),
      ),
    );
  }
}
