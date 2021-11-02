import 'package:flutter/material.dart';
import 'package:portfolio/Model/board_model.dart';
import 'package:portfolio/Screens/Admin/screen/ProjectManage/components/board_manage_form.dart';

class BoardControlPanel extends StatefulWidget {
  const BoardControlPanel({Key? key}) : super(key: key);

  @override
  _BoardControlPanelState createState() => _BoardControlPanelState();
}

class _BoardControlPanelState extends State<BoardControlPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 180,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () async {
                await boardManageDialog(new Board());
              },
              icon: Icon(Icons.add),
              label: Text("프로젝트 추가"),
              style: ElevatedButton.styleFrom(primary: Colors.green[500]),
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 180,
            height: 40,
            child: ElevatedButton.icon(
              onPressed: () async {},
              icon: Icon(Icons.delete),
              label: Text("프로젝트 삭제"),
              style: ElevatedButton.styleFrom(primary: Colors.yellow[800]),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> boardManageDialog(Board board) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(board.title ?? "프로젝트 추가"),
            content: BoardManageForm(board: board),
          );
        });
  }
}
