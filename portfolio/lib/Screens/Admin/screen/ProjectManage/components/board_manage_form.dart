import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/Model/board_model.dart';

class BoardManageForm extends StatefulWidget {
  const BoardManageForm({Key? key, required this.board}) : super(key: key);
  final Board board;

  @override
  _BoardManageFormState createState() => _BoardManageFormState();
}

class _BoardManageFormState extends State<BoardManageForm> {
  HtmlEditorController htmlEditorController = new HtmlEditorController();

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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _titleRow(),
            SizedBox(height: 20),
            _contentsRow(),
            SizedBox(height: 20),
            _buttonRow(),
          ],
        ),
      ),
    );
  }

  Widget _buttonRow() {
    return Container(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () async {},
              icon: Icon(Icons.save),
              label: Text("저장"),
              style: ElevatedButton.styleFrom(primary: Colors.green[500]),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () async {},
              icon: Icon(Icons.cancel),
              label: Text("취소"),
              style: ElevatedButton.styleFrom(primary: Colors.green[500]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentsRow() {
    return Container(
      child: HtmlEditor(
        controller: htmlEditorController,
        htmlEditorOptions: HtmlEditorOptions(
          hint: "프로젝트 소개 내용을 입력해주세요.",
          initialText: widget.board.boardDetail.contents,
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
          // aboutController.stackCtgController(entry.key, value);
        },
      ),
    );
  }
}
