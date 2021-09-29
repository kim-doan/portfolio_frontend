class ProfileModel {
  String userNo = "";
  String userId = "";
  String? createTime;
  String username = "";
  bool enabled = false;
  List<String> roles = List.from([]);

  ProfileModel({this.userNo = "", this.userId = "", this.createTime, this.username = "", this.enabled = false});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
