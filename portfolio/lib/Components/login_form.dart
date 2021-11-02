import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:portfolio/Components/register_form.dart';
import 'package:portfolio/Controller/loading_controller.dart';
import 'package:portfolio/Controller/user_controller.dart';
import 'package:portfolio/constants.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var loadingController = Get.put(LoadingController());
  var userController = Get.put(UserController());

  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  bool obscureText = true;
  Color obscureColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(300),
      height: ScreenUtil().setHeight(280),
      child: Column(
        children: [
          Container(
            height: ScreenUtil().setHeight(70),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: idController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  border: InputBorder.none,
                  hintText: "아이디",
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            height: ScreenUtil().setHeight(70),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                obscureText: obscureText,
                controller: pwController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility, color: obscureColor),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                        obscureColor = obscureText ? Colors.grey : kPrimaryColor;
                      });
                    },
                  ),
                  border: InputBorder.none,
                  hintText: "비밀번호",
                ),
                onSubmitted: (value) async {
                  loginBtnPressed();
                },
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "아직 계정이 없으신가요? ",
                style: TextStyle(fontSize: 15),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  child: Text(
                    "계정생성",
                    style: TextStyle(color: Colors.blue[800], fontSize: 15),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    await registerDialog();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
              width: 300,
              height: ScreenUtil().setHeight(50),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextButton(
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    backgroundColor: Colors.blue[800],
                    primary: Colors.white),
                child: Text("로그인"),
                onPressed: loginBtnPressed,
              )),
        ],
      ),
    );
  }

  void loginBtnPressed() async {
    await userController.doLogin({"userId": idController.text, "userPassword": pwController.text});

    var loginSession = userController.loginSession.value;

    if (loginSession.success ?? false) {
      await userController.validToken(loginSession.token!);
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: userController.profile.value.username + " 님 환영합니다.",
          backgroundColor: Colors.black,
          webPosition: "center",
          webBgColor: "#21a366",
          timeInSecForIosWeb: 3,
          textColor: Colors.white);
    } else {
      Fluttertoast.showToast(
          msg: userController.loginSession.value.msg ?? "",
          backgroundColor: Colors.black,
          webPosition: "center",
          webBgColor: "#ea4335",
          timeInSecForIosWeb: 3,
          textColor: Colors.white);
    }
  }

  Future<String?> registerDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("회원가입"),
            content: RegisterForm(),
          );
        });
  }
}
