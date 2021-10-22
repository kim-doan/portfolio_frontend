import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/Components/bottom_bar.dart';
import 'package:portfolio/Components/custom_tab.dart';
import 'package:portfolio/Components/custom_tab_bar.dart';
import 'package:portfolio/Components/login_form.dart';
import 'package:portfolio/Controller/user_controller.dart';
import 'package:portfolio/Screens/About/about_screen.dart';
import 'package:portfolio/Screens/Admin/admin_screen.dart';
import 'package:portfolio/Screens/Home/home_screen.dart';
import 'package:portfolio/Screens/Projects/projects_screen.dart';
import 'package:portfolio/Utils/content_view.dart';
import 'package:portfolio/Utils/tab_controller_handler.dart';
import 'package:portfolio/Utils/view_wrapper.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  TabController? tabController;
  ItemScrollController? itemScrollController;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  double? screenHeight;
  double? screenWidth;
  double? topPadding;
  double? bottomPadding;
  double? sidePadding;

  var userController = Get.put(UserController());

  List<ContentView> contentViews = [
    ContentView(
        tab: CustomTab(
          title: 'Home',
        ),
        content: HomeScreen()),
    ContentView(
        tab: CustomTab(
          title: 'About',
        ),
        content: AboutScreen()),
    ContentView(
        tab: CustomTab(
          title: 'Projects',
        ),
        content: ProejctsScreen()),
    ContentView(
        tab: CustomTab(
          title: 'Contact',
        ),
        content: new Container()),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: contentViews.length, vsync: this);
    itemScrollController = ItemScrollController();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    topPadding = screenHeight! * 0.05;
    bottomPadding = screenHeight! * 0.03;
    sidePadding = screenWidth! * 0.06;

    print('Width: $screenWidth');
    print('Height: $screenHeight');
    return Scaffold(
      backgroundColor: Color(0xff1e1e24),
      key: scaffoldKey,
      endDrawer: drawer(),
      body: Padding(
        padding: EdgeInsets.only(top: topPadding!, bottom: bottomPadding!),
        child: ViewWrapper(desktopView: desktopView(), mobileView: mobileView()),
      ),
    );
  }

  Widget desktopView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        /// Tab Bar
        Container(
          height: screenHeight! * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 30),
              profilePanel(),
              adminMenu(),
              Spacer(),
              CustomTabBar(controller: tabController!, tabs: contentViews.map((e) => e.tab).toList()),
            ],
          ),
        ),

        /// Tab Bar View
        Container(
          height: screenHeight! * 0.8,
          child: TabControllerHandler(
            tabController: tabController!,
            child: TabBarView(
              controller: tabController,
              children: contentViews.map((e) => e.content).toList(),
            ),
          ),
        ),

        /// Bottom Bar
        BottomBar()
      ],
    );
  }

  Widget mobileView() {
    return Padding(
      padding: EdgeInsets.only(left: sidePadding!, right: sidePadding!),
      child: Container(
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                profilePanel(),
                adminMenu(),
                Spacer(),
                IconButton(
                    iconSize: screenWidth! * 0.08,
                    icon: Icon(Icons.menu_rounded),
                    color: Colors.white,
                    splashColor: Colors.transparent,
                    onPressed: () => scaffoldKey.currentState!.openEndDrawer()),
              ],
            ),
            Expanded(
              child: ScrollablePositionedList.builder(
                scrollDirection: Axis.vertical,
                itemScrollController: itemScrollController,
                itemCount: contentViews.length,
                itemBuilder: (context, index) => contentViews[index].content,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget adminMenu() {
    return Obx(() {
      return Container(
          child: userController.profile.value.roles.contains("ROLE_ADMIN")
              ? Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      child: Text(
                        "[관리자 페이지]",
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () => Get.to(() => AdminScreen()),
                    ),
                  ),
                )
              : new Container());
    });
  }

  Widget profilePanel() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Obx(() {
          return Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(42))),
                child: Icon(
                  userController.profile.value.enabled ? Icons.person : Icons.lock_open,
                  color: Colors.white,
                ),
              ),
              Text(
                userController.profile.value.enabled ? userController.profile.value.username + " 님" : "로그인",
                style: TextStyle(color: Colors.white),
              ),
            ],
          );
        }),
        onTap: () async {
          if (userController.profile.value.enabled) {
            await logOutPress();
          } else {
            await loginDialog();
          }
        },
      ),
    );
  }

  Future<void>? logOutPress() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("로그아웃"),
              content: Text("로그아웃 하시겠습니까?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("취소"),
                ),
                TextButton(
                    onPressed: () async {
                      await userController.doLogout();
                      Navigator.of(context).pop();
                    },
                    child: Text("확인")),
              ],
            ));
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

  Widget drawer() {
    return Container(
      width: screenWidth! * 0.5,
      child: Drawer(
        child: ListView(
          children: [Container(height: screenHeight! * 0.1)] +
              contentViews
                  .map((e) => Container(
                        child: ListTile(
                          title: Text(
                            e.tab.title,
                            style: Theme.of(context).textTheme.button,
                          ),
                          onTap: () {
                            itemScrollController!
                                .scrollTo(index: contentViews.indexOf(e), duration: Duration(milliseconds: 300));
                            Navigator.pop(context);
                          },
                        ),
                      ))
                  .toList(),
        ),
      ),
    );
  }
}
