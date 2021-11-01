class BoardModel {
  bool? success;
  String? code;
  String? msg;
  int rowSize = 0;
  int totalCount = 0;
  int totalPages = 0;
  List<Board> data = [];

  BoardModel(
      {this.success,
      this.code,
      this.msg,
      this.rowSize = 0,
      this.totalCount = 0,
      this.totalPages = 0,
      List<Board>? data})
      : data = data ?? [];

  BoardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    msg = json['msg'];
    rowSize = json['rowSize'] ?? 0;
    totalCount = json['totalCount'] ?? 0;
    totalPages = json['totalPages'] ?? 0;

    data = new List<Board>.from([]);
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new Board.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['rowSize'] = this.rowSize;
    data['totalCount'] = this.totalCount;
    data['totalPages'] = this.totalPages;
    data['data'] = this.data.map((v) => v.toJson()).toList();

    return data;
  }
}

class Board {
  String? boardId;
  String? title;
  String? thumbnail;
  String? createUser;
  DateTime? createTime;
  int used = 0;
  BoardDetail boardDetail = new BoardDetail();

  Board(
      {this.boardId,
      this.title,
      this.thumbnail,
      this.createUser,
      this.createTime,
      this.used = 0,
      BoardDetail? boardDetail})
      : boardDetail = boardDetail ?? new BoardDetail();

  Board.fromJson(Map<String, dynamic> json) {
    boardId = json['boardId'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    createUser = json['createUser'];
    createTime = json['createTime'] == null ? null : DateTime.parse(json["createTime"]);
    used = json['used'] ?? 0;
    if (json['boardDetail'] != null) {
      boardDetail = new BoardDetail.fromJson(json['boardDetail']);
    } else {
      boardDetail = new BoardDetail();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['boardId'] = this.boardId;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['createUser'] = this.createUser;
    data['createTime'] = this.createTime == null ? "" : this.createTime!.toIso8601String();
    data['used'] = this.used;
    data['boardDetail'] = this.boardDetail.toJson();
    return data;
  }
}

class BoardDetail {
  String? boardId;
  String contents = "";
  String? fileCodes;

  BoardDetail({this.boardId, this.contents = "", this.fileCodes});

  BoardDetail.fromJson(Map<String, dynamic> json) {
    boardId = json['boardId'];
    contents = json['contents'];
    fileCodes = json['fileCodes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['boardId'] = this.boardId;
    data['contents'] = this.contents;
    data['fileCodes'] = this.fileCodes;
    return data;
  }
}
