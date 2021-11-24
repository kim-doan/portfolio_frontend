import 'package:flutter/material.dart';

class StackInfo extends StatefulWidget {
  const StackInfo({Key? key}) : super(key: key);

  @override
  _StackInfoState createState() => _StackInfoState();
}

final isSelected = <bool>[false, false, false];

class _StackInfoState extends State<StackInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      color: Colors.red,
      child: Text("dd"),
    );
  }
}
