import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DateBetween extends StatelessWidget {
  final String title;
  final String? hintText1;
  final String? hintText2;
  final Function()? tap;
  final Function()? tap2;
  final String? initialValue;
  final String? initialValue2;
  final Function(String value)? onChanged;
  final Function(String value)? onChanged2;
  const DateBetween(
      {Key? key,
      required this.title,
      this.tap,
      this.tap2,
      this.hintText1,
      this.hintText2,
      this.initialValue,
      this.initialValue2,
      this.onChanged,
      this.onChanged2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        SizedBox(width: 5),
        Expanded(
          child: TextFormField(
            initialValue: this.initialValue,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              hintText: hintText1,
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              fillColor: Colors.white,
              focusColor: Colors.white,
            ),
            keyboardType: TextInputType.number,
            onTap: tap,
            onChanged: onChanged,
          ),
        ),
        Text(" ~ ", style: TextStyle(color: Colors.white)),
        Expanded(
          child: TextFormField(
            initialValue: this.initialValue2,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              hintText: hintText2,
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              fillColor: Colors.white,
              focusColor: Colors.white,
            ),
            keyboardType: TextInputType.number,
            onTap: tap2,
            onChanged: onChanged2,
          ),
        ),
      ],
    );
  }
}
