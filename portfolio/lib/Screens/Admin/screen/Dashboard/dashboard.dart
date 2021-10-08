import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Text("ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"),
          ],
        ),
      ),
    );
  }
}
