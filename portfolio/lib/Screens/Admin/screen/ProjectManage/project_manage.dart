import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/Controller/board_controller.dart';
import 'package:portfolio/Model/board_model.dart';
import 'package:portfolio/Model/pageable_model.dart';
import 'package:portfolio/Screens/Admin/screen/ProjectManage/components/board_control_panel.dart';
import 'package:portfolio/Screens/Admin/screen/ProjectManage/components/board_manage_form.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class ProjectManage extends StatefulWidget {
  const ProjectManage({Key? key}) : super(key: key);

  @override
  _ProjectManageState createState() => _ProjectManageState();
}

final int rowPerPage = 10;
List<BoardModel> pagenatedDataSource = [];

class _ProjectManageState extends State<ProjectManage> {
  var boardController = Get.put(BoardController());

  late BoardDataSource _boardDataSource;
  bool showLoadingIndicator = true;
  double pageCount = 0;
  int page = 0;

  @override
  void initState() {
    super.initState();
    _boardDataSource = BoardDataSource([]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width > 715 ? size.width * 0.5 : size.width * 0.8,
      child: SfTheme(
        data: SfThemeData(
            dataPagerThemeData: SfDataPagerThemeData(itemTextStyle: TextStyle(fontFamily: 'AppleSdGothicNeo')),
            dataGridThemeData:
                SfDataGridThemeData(headerColor: const Color(0xff009889), headerHoverColor: const Color(0xffabd0bc))),
        child: Column(
          children: [
            BoardControlPanel(),
            SizedBox(height: 20),
            SizedBox(
              height: 545,
              child: _buildStack(),
            ),
            Container(
              color: Colors.white,
              child: SfDataPager(
                pageCount:
                    boardController.totalPages.value.toDouble() <= 0 ? 1 : boardController.totalPages.value.toDouble(),
                direction: Axis.horizontal,
                onPageNavigationStart: (int pageIndex) async {
                  setState(() {
                    showLoadingIndicator = true;
                  });
                },
                delegate: _boardDataSource,
                onPageNavigationEnd: (int pageIndex) async {
                  await boardController.getBoardPage(new Pageable(size: 10, page: pageIndex));
                  setState(() {
                    showLoadingIndicator = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataGrid() {
    final DataGridController dataGridController = DataGridController();

    return SfDataGrid(
        source: BoardDataSource(boardController.boardPosts),
        isScrollbarAlwaysShown: true,
        columnWidthMode: ColumnWidthMode.fill,
        selectionMode: SelectionMode.single,
        controller: dataGridController,
        onCellTap: (details) async {
          dataGridController.selectedIndex = details.rowColumnIndex.rowIndex - 1;
          boardController.setFocusedRowHandle(dataGridController.selectedIndex);
          await boardManageDialog(boardController.boardPosts[dataGridController.selectedIndex]);
        },
        columns: <GridColumn>[
          GridColumn(
              columnName: 'title',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    '제목',
                    style: TextStyle(fontFamily: 'AppleSdGothicNeo', color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'createUser',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    '작성자',
                    style: TextStyle(fontFamily: 'AppleSdGothicNeo', color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'createTime',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    '작성일자',
                    style: TextStyle(fontFamily: 'AppleSdGothicNeo', color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'used',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    '활성화',
                    style: TextStyle(fontFamily: 'AppleSdGothicNeo', color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  )))
        ]);
  }

  Future<String?> boardManageDialog(Board board) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(board.title ?? ""),
            content: BoardManageForm(board: board),
          );
        });
  }

  Widget _buildStack() {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];
      stackChildren.add(_buildDataGrid());

      if (showLoadingIndicator) {
        stackChildren.add(Container(
            color: Colors.white,
            child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ))));
      }

      return stackChildren;
    }

    return Stack(
      children: _getChildren(),
    );
  }
}

class BoardDataSource extends DataGridSource {
  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  BoardDataSource(List<Board> board) {
    dataGridRows = board
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell(columnName: "title", value: e.title),
              DataGridCell(columnName: "createUser", value: e.createUser),
              DataGridCell(columnName: "createTime", value: e.createTime),
              DataGridCell(columnName: "used", value: e.used),
            ]))
        .toList();
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == "createTime") {
        return Container(
          child: Center(
            child: Text(
              new DateFormat("yyyy-MM-dd").format(DateTime.parse(dataGridCell.value.toString())),
            ),
          ),
        );
      } else {
        return Container(
          child: Center(
            child: Text(
              dataGridCell.value.toString(),
              style: TextStyle(fontFamily: 'AppleSdGothicNeo'),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }
    }).toList());
  }
}
