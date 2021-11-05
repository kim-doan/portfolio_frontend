import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:portfolio/Controller/board_controller.dart';
import 'package:portfolio/Controller/user_controller.dart';
import 'package:portfolio/Model/board_model.dart';
import 'package:portfolio/Model/common_result_model.dart';
import 'package:portfolio/Model/pageable_model.dart';

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
          Row(
            children: [
              Expanded(flex: 1, child: _thumnailRow()),
              SizedBox(width: 20),
              Expanded(flex: 3, child: _titleRow()),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 400,
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
                  if (widget.board.boardId == null || widget.board.boardId == "") {
                    widget.board.createUser = userController.profile.value.username;
                    widget.board.createTime = new DateTime.now();
                  }
                  widget.board.used = 1;
                  widget.board.boardDetail.contents = await htmlEditorController.getText();

                  CommonResultModel result = await boardController.saveBoard(widget.board);

                  if (result.success) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: "게시글을 저장했습니다.",
                        backgroundColor: Colors.black,
                        webPosition: "center",
                        webBgColor: "#21a366",
                        timeInSecForIosWeb: 3,
                        textColor: Colors.white);
                    await boardController.getBoardPage(new Pageable());
                  } else {
                    Fluttertoast.showToast(
                        msg: result.msg ?? "알 수 없는 오류로 저장에 실패했습니다.",
                        backgroundColor: Colors.black,
                        webPosition: "center",
                        webBgColor: "#ea4335",
                        timeInSecForIosWeb: 3,
                        textColor: Colors.white);
                  }
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
    return HtmlEditor(
      controller: htmlEditorController,
      htmlEditorOptions: HtmlEditorOptions(
        hint: "프로젝트 소개 내용을 입력해주세요.",
        initialText: widget.board.boardDetail.contents,
        autoAdjustHeight: false,
      ),
      otherOptions: OtherOptions(
        height: 400,
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
            widget.board.title = value;
          });
        },
      ),
    );
  }

  Widget _thumnailRow() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Container(
            width: 150,
            height: 120,
            decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
            child: Center(
                child: (widget.board.thumbnail == null || widget.board.thumbnail == "")
                    ? Icon(Icons.image_not_supported)
                    : Image.memory(Base64Decoder().convert(widget.board.thumbnail!)))),
        onTap: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles();

          if (result == null) return;

          Uint8List? bytes = result.files.single.bytes;

          setState(() {
            widget.board.thumbnail = base64Encode(bytes!);
          });
        },
      ),
    );
  }
}
