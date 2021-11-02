import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:portfolio/Controller/board_controller.dart';
import 'package:portfolio/Controller/user_controller.dart';
import 'package:portfolio/Model/board_model.dart';
import 'package:portfolio/Model/common_result_model.dart';

class BoardManageForm extends StatefulWidget {
  const BoardManageForm({Key? key, required this.board}) : super(key: key);
  final Board board;

  @override
  _BoardManageFormState createState() => _BoardManageFormState();
}

class _BoardManageFormState extends State<BoardManageForm> {
  HtmlEditorController htmlEditorController = new HtmlEditorController();
  var boardController = Get.put(BoardController());
  var userController = Get.put(UserController());

  Board boardParam = new Board();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width > 715 ? size.width / 2 : size.width,
      height: size.width > 715 ? size.height / 1.5 : size.height,
      child: Column(
        children: [
          _titleRow(),
          SizedBox(height: 20),
          Container(
            height: 450,
            child: _contentsRow(),
          ),
          SizedBox(height: 20),
          Expanded(
            child: _buttonRow(),
          ),
        ],
      ),
    );
  }

  Widget _buttonRow() {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () async {
                  boardParam.createUser = userController.profile.value.username;
                  boardParam.createTime = new DateTime.now();
                  boardParam.used = 1;
                  boardParam.boardDetail.contents = await htmlEditorController.getText();

                  CommonResultModel result = await boardController.saveBoard(boardParam);
                },
                icon: Icon(Icons.save),
                label: Text("저장"),
                style: ElevatedButton.styleFrom(primary: Colors.green[500]),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () async {},
                icon: Icon(Icons.cancel),
                label: Text("취소"),
                style: ElevatedButton.styleFrom(primary: Colors.green[500]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentsRow() {
    return Expanded(
      child: HtmlEditor(
        controller: htmlEditorController,
        htmlEditorOptions: HtmlEditorOptions(
          hint: "프로젝트 소개 내용을 입력해주세요.",
          initialText: widget.board.boardDetail.contents,
          autoAdjustHeight: false,
        ),
        otherOptions: OtherOptions(
          height: 450,
        ),
      ),
    );
  }

  Widget _titleRow() {
    return Container(
      child: TextFormField(
        initialValue: widget.board.title,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          hintText: "프로젝트명",
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          fillColor: Colors.white,
          focusColor: Colors.white,
        ),
        onChanged: (value) {
          setState(() {
            boardParam.title = value;
          });
        },
      ),
    );
  }
}
