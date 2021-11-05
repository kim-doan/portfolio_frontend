import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/Model/board_model.dart';

class BoardDetailForm extends StatelessWidget {
  const BoardDetailForm({Key? key, required this.board}) : super(key: key);
  final Board board;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget html = Html(data: board.boardDetail.contents);

    return Container(
      width: size.width > 715 ? size.width / 2 : size.width,
      height: size.width > 715 ? size.height / 1.5 : size.height,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _writerRow(),
            SizedBox(height: 20),
            Container(
              // color: Colors.red,
              child: html,
            )
          ],
        ),
      ),
    );
  }

  Widget _writerRow() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 2, color: Colors.grey),
      )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(board.createUser ?? ""),
              Text(
                DateFormat("yyyy-MM-dd HH:mm").format(board.createTime!),
                style: TextStyle(fontSize: 14, color: Colors.grey[400]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
