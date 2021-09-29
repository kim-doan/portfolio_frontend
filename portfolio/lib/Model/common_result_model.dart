class CommonResultModel {
  bool success = false;
  String? code;
  String? msg;

  CommonResultModel({this.success = false, this.code, this.msg});

  CommonResultModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }
}
