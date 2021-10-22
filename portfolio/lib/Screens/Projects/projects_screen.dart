import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/Controller/board_controller.dart';
import 'package:portfolio/Screens/Home/components/background.dart';

class ProejctsScreen extends StatefulWidget {
  const ProejctsScreen({Key? key}) : super(key: key);

  @override
  _ProejctsScreenState createState() => _ProejctsScreenState();
}

class _ProejctsScreenState extends State<ProejctsScreen> {
  var boardController = Get.put(BoardController());

  @override
  void initState() {
    super.initState();
    boardController.getBoardPage();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
        child: Container(
      width: size.width,
      height: size.height,
      child: Padding(
        padding: EdgeInsets.only(
          top: responsivePadding(size.width) - 40,
          bottom: responsivePadding(size.width) - 40,
          left: responsivePadding(size.width),
          right: responsivePadding(size.width),
        ),
        child: Column(
          children: [
            Obx(() {
              return Expanded(
                child: GridView.builder(
                    itemCount: boardController.boardPosts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount(size.width),
                      childAspectRatio: 2 / 1.2,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: Colors.white,
                        child: GridTile(
                          child: Container(
                            child: (boardController.boardPosts[index].thumbnail == null ||
                                    boardController.boardPosts[index].thumbnail == "")
                                ? new Container()
                                : Image.memory(
                                    Base64Decoder().convert(boardController.boardPosts[index].thumbnail!),
                                    fit: BoxFit.fill,
                                  ),
                          ),
                          footer: GridTileBar(
                            backgroundColor: Colors.grey.withOpacity(0.9),
                            title: Text(boardController.boardPosts[index].title ?? ""),
                          ),
                        ),
                      );
                    }),
              );
            }),
          ],
        ),
      ),
    ));
  }

  int crossAxisCount(double width) {
    if (width > 1600) {
      return 4;
    } else if (width > 1200) {
      return 4;
    } else if (width > 800) {
      return 3;
    } else {
      return 2;
    }
  }

  double responsivePadding(double width) {
    if (width > 1600) {
      return 100;
    } else if (width > 1200) {
      return 80;
    } else if (width > 800) {
      return 60;
    } else {
      return 30;
    }
  }
}
