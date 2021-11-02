import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:portfolio/Components/login_form.dart';
import 'package:portfolio/Controller/loading_controller.dart';
import 'package:portfolio/Controller/user_controller.dart';
import 'package:portfolio/Model/common_result_model.dart';
import 'package:portfolio/Screens/Main/main_screen.dart';
import 'package:portfolio/constants.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  var loadingController = Get.put(LoadingController());
  var userController = Get.put(UserController());

  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwCheckController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool obscureText = true;
  Map<String, bool> formValidate = {
    "id": false,
    "pw": false,
    "pwCheck": false,
    "username": false,
  };

  Color obscureColor = Colors.grey;
  Color pwCheckColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(300),
      height: ScreenUtil().setHeight(400),
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
                onChanged: (value) {
                  if (value.trim().length > 1) {
                    formValidate["id"] = true;
                  } else {
                    formValidate["id"] = false;
                  }
                },
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
                onChanged: (value) {
                  setState(() {
                    if (value.trim().length > 0) {
                      formValidate["pw"] = true;
                    } else {
                      formValidate["pw"] = true;
                    }
                  });
                },
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
                controller: pwCheckController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  suffixIcon: Icon(
                    Icons.check,
                    color: pwCheckColor,
                  ),
                  border: InputBorder.none,
                  hintText: "비밀번호 확인",
                ),
                onChanged: (value) {
                  if (pwController.text == value) {
                    setState(() {
                      pwCheckColor = Colors.green;
                      formValidate["pwCheck"] = true;
                    });
                  } else {
                    setState(() {
                      pwCheckColor = Colors.red;
                      formValidate["pwCheck"] = false;
                    });
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 25.h),
          Container(
            height: ScreenUtil().setHeight(70),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey), borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: nameController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  border: InputBorder.none,
                  hintText: "별명 (2~5자)",
                ),
                onChanged: (value) {
                  if (value.trim().length >= 2 && value.trim().length <= 5) {
                    setState(() {
                      formValidate["username"] = true;
                    });
                  } else {
                    setState(() {
                      formValidate["username"] = true;
                    });
                  }
                },
              ),
            ),
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
                child: Text("회원가입"),
                onPressed: () async {
                  bool validCheck = await validationCheck();

                  if (validCheck) {
                    await userController.register({
                      "userId": idController.text,
                      "userPassword": pwController.text,
                      "userName": nameController.text
                    });

                    if (userController.registerState.value.success) {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: "회원가입을 축하드립니다.",
                          backgroundColor: Colors.black,
                          webPosition: "center",
                          webBgColor: "#21a366",
                          timeInSecForIosWeb: 3,
                          textColor: Colors.white);
                      await loginDialog();
                    } else {
                      Fluttertoast.showToast(
                          msg: userController.registerState.value.msg ?? "dd",
                          backgroundColor: Colors.black,
                          webPosition: "center",
                          webBgColor: "#ea4335",
                          timeInSecForIosWeb: 3,
                          textColor: Colors.white);
                    }
                  }
                },
              )),
        ],
      ),
    );
  }

  Future<String?> loginDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("로그인"),
            content: LoginForm(),
          );
        });
  }

  Future<bool> validationCheck() async {
    bool success = true;

    formValidate.forEach((key, value) {
      if (formValidate[key] == false) {
        Fluttertoast.showToast(
            msg: "회원가입 정보를 정확히 입력해주세요.",
            backgroundColor: Colors.black,
            webPosition: "center",
            webBgColor: "#ea4335",
            timeInSecForIosWeb: 3,
            textColor: Colors.white);
        success = false;
      }
    });

    return success;
  }
}
