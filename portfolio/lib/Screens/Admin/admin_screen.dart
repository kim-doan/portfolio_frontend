import 'package:flutter/material.dart';
import 'package:portfolio/Screens/Admin/screen/dashboard.dart';
import 'package:portfolio/Screens/Admin/screen/user_manage.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int selectedIndex = 0;
  bool expended = false;

  List<Widget> screens = [Dashboard(), UserManage()];

  List<String> menuName = ["대시보드", "사용자관리"];

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
                  padding: const EdgeInsets.all(50.0),
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
                      child: Container(
                    width: expended ? size.width - 250 : size.width - 72,
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
