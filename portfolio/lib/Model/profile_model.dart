class ProfileModel {
  bool success = false;
  String? code;
  String? msg;
  int rowSize = 0;
  int totalCount = 0;
  int totalPages = 0;
  List<Profile> data = [];

  ProfileModel(
      {this.success = false,
      this.code,
      this.msg,
      this.rowSize = 0,
      this.totalCount = 0,
      this.totalPages = 0,
      this.data = const []});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    msg = json['msg'];
    rowSize = json['rowSize'];
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    if (json['data'] != null) {
      data = new List<Profile>.from([]);
      json['data'].forEach((v) {
        data.add(new Profile.fromJson(v));
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

class Profile {
  String userNo = "";
  String userId = "";
  String? createTime;
  String username = "";
  bool enabled = false;
  List<String> roles = List.from([]);

  Profile({this.userNo = "", this.userId = "", this.createTime, this.username = "", this.enabled = false});

  Profile.fromJson(Map<String, dynamic> json) {
    userNo = json['userNo'];
    userId = json['userId'];
    createTime = json['createTime'];
    username = json['username'];
    enabled = json['enabled'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userNo'] = this.userNo;
    data['userId'] = this.userId;
    data['createTime'] = this.createTime;
    data['username'] = this.username;
    data['enabled'] = this.enabled;
    data['roles'] = this.roles;
    return data;
  }
}
