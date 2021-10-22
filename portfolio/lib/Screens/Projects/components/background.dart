import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:portfolio/Controller/loading_controller.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var loadingController = Get.put(LoadingController());

    return Stack(
      children: [
        Container(
          width: size.width,
          // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Stack(
            children: <Widget>[
              child,
            ],
          ),
        ),
        Obx(() {
          if (loadingController.isLoading.value)
            return Opacity(
              opacity: 0.9,
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.black,
              ),
            );
          else
            return new Container();
        }),
        Obx(() {
          if (loadingController.isLoading.value)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitWave(
                  color: Colors.white,
                  size: 50.0,
                ),
                SizedBox(height: 10),
                Text(
                  loadingController.text.value,
                  style: TextStyle(color: Colors.white),
                )
              ],
            );
          else
            return new Container();
        })
      ],
    );
  }
}
