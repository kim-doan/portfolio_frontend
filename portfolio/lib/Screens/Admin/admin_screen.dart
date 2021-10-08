import 'package:flutter/material.dart';
import 'package:portfolio/Screens/Admin/screen/AboutManage/about_manage.dart';
import 'package:portfolio/Screens/Admin/screen/Dashboard/dashboard.dart';
import 'package:portfolio/Screens/Admin/screen/UserManage/user_manage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int selectedIndex = 0;
  bool expended = false;

  List<Widget> screens = [Dashboard(), UserManage(), AboutManage()];

  List<String> menuName = ["대시보드", "사용자관리", "자기소개 관리"];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Row(
          children: [
            GestureDetector(
              child: NavigationRail(
                extended: expended,
                destinations: [
                  NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text("대시보드")),
                  NavigationRailDestination(icon: Icon(Icons.person), label: Text("사용자관리")),
                  NavigationRailDestination(icon: Icon(Icons.book), label: Text("자기소개 관리")),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              onTap: () {
                setState(() {
                  expended = !expended;
                });
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(50.0.sp),
                  child: Text(
                    menuName[selectedIndex],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        width: size.width - 280,
                        padding: EdgeInsets.all(50.0.sp),
                        child: screens[selectedIndex],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
