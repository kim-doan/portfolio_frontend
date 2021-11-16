import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/Controller/user_controller.dart';
import 'package:portfolio/Model/pageable_model.dart';
import 'package:portfolio/Model/profile_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class UserManage extends StatefulWidget {
  const UserManage({Key? key}) : super(key: key);

  @override
  _UserManageState createState() => _UserManageState();
}

final int rowsPerPage = 10;
List<Profile> pagenatedDataSource = [];

class _UserManageState extends State<UserManage> {
  var userController = Get.put(UserController());

  late UserProfileDataSource _userProfileDataSource;
  bool showLoadingIndicator = true;
  double pageCount = 0;
  int page = 0;

  @override
  void initState() {
    super.initState();
    _userProfileDataSource = UserProfileDataSource([]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width > 715 ? size.width * 0.5 : size.width * 0.8,
      color: Colors.white,
      child: SfTheme(
        data: SfThemeData(
            dataPagerThemeData: SfDataPagerThemeData(itemTextStyle: TextStyle(fontFamily: 'NanumSquare')),
            dataGridThemeData:
                SfDataGridThemeData(headerColor: const Color(0xff009889), headerHoverColor: const Color(0xffabd0bc))),
        child: Column(
          children: [
            SizedBox(
              height: 600,
              child: _buildStack(),
            ),
            Container(
              child: SfDataPager(
                pageCount:
                    userController.totalPages.value.toDouble() <= 0 ? 1 : userController.totalPages.value.toDouble(),
                direction: Axis.horizontal,
                onPageNavigationStart: (int pageIndex) async {
                  setState(() {
                    showLoadingIndicator = true;
                  });
                },
                delegate: _userProfileDataSource,
                onPageNavigationEnd: (int pageIndex) async {
                  await userController.getUserAll(new Pageable(size: 10, page: pageIndex));
                  setState(() {
                    showLoadingIndicator = false;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDataGrid() {
    return SfDataGrid(
        source: UserProfileDataSource(userController.userList),
        columnWidthMode: ColumnWidthMode.fill,
        selectionMode: SelectionMode.single,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'userId',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    '아이디',
                    style: TextStyle(fontFamily: 'NanumSquare', color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'userName',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    '닉네임',
                    style: TextStyle(fontFamily: 'NanumSquare', color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'createTime',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    '생성일자',
                    style: TextStyle(fontFamily: 'NanumSquare', color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'enabled',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.center,
                  child: Text(
                    '활성화',
                    style: TextStyle(fontFamily: 'NanumSquare', color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  )))
        ]);
  }

  Widget _buildStack() {
    List<Widget> _getChildren() {
      final List<Widget> stackChildren = [];
      stackChildren.add(_buildDataGrid());

      if (showLoadingIndicator) {
        stackChildren.add(Container(
            color: Colors.black12,
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

class UserProfileDataSource extends DataGridSource {
  UserProfileDataSource(List<Profile> profile) {
    dataGridRows = profile
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell(columnName: 'userId', value: e.userId),
              DataGridCell(columnName: 'username', value: e.username),
              DataGridCell(columnName: 'createTime', value: e.createTime),
              DataGridCell(columnName: 'enabled', value: e.enabled),
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

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
              style: TextStyle(fontFamily: 'NanumSquare'),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }
    }).toList());
  }
}
