class AboutModel {
  String name = "";
  String email = "";
  String phoneNo = "";
  int career = 0;
  List<AboutDetail> careerList = [];
  List<AboutDetail> projectList = [];

  AboutModel(
      {this.name = "",
      this.email = "",
      this.phoneNo = "",
      this.career = 0,
      this.careerList = const [],
      this.projectList = const []});

  AboutModel copyWith(
      {String name = "",
      String email = "",
      String phoneNo = "",
      int career = 0,
      List<AboutDetail> careerList = const [],
      List<AboutDetail> projectList = const []}) {
    return AboutModel(
        name: this.name = "",
        email: this.email = "",
        phoneNo: this.phoneNo = "",
        career: this.career = 0,
        careerList: this.careerList = const [],
        projectList: this.projectList = const []);
  }

  AboutModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    career = json['career'];
    if (json['careerList'] != null) {
      careerList = new List<AboutDetail>.from([]);
      json['careerList'].forEach((v) {
        careerList.add(new AboutDetail.fromJson(v));
      });
    }
    if (json['projectList'] != null) {
      projectList = new List<AboutDetail>.from([]);
      json['projectList'].forEach((v) {
        projectList.add(new AboutDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNo'] = this.phoneNo;
    data['career'] = this.career;
    data['careerList'] = this.careerList.map((v) => v.toJson()).toList();
    data['projectList'] = this.projectList.map((v) => v.toJson()).toList();
    return data;
  }
}

class AboutDetail {
  DateTime? startDate;
  DateTime? endDate;
  String contents = "";

  AboutDetail({this.startDate, this.endDate, this.contents = ""});

  AboutDetail.fromJson(Map<String, dynamic> json) {
    startDate = DateTime.parse(json['startDate']);
    endDate = DateTime.parse(json['endDate']);
    contents = json['contents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['contents'] = this.contents;
    return data;
  }
}
