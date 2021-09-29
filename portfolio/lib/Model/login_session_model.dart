class LoginSessionModel {
  bool? success;
  String? code;
  String? msg;
  String? token;

  LoginSessionModel({this.success, this.code, this.msg, this.token});

  LoginSessionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    msg = json['msg'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['token'] = this.token;
    return data;
  }
}
