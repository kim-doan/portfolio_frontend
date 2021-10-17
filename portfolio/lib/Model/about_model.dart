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
      List<AboutDetail>? careerList,
      List<AboutDetail>? projectList})
      : careerList = careerList ?? [],
      projectList = projectList ?? []
      ;

  AboutModel copyWith({
    String name = "",
    String email = "",
    String phoneNo = "",
    int career = 0,
    List<AboutDetail>? careerList,
    List<AboutDetail>? projectList,
  })
   {
    return AboutModel(
        name: this.name,
        email: this.email,
        phoneNo: this.phoneNo,
        career: this.career,
        careerList: this.careerList,
        projectList: this.projectList);
  }

  AboutModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneNo = json['phoneNo'];
    career = json['career'];
    careerList = new List<AboutDetail>.from([]);
    if (json['careerList'] != null) {
      json['careerList'].forEach((v) {
        careerList.add(new AboutDetail.fromJson(v));
      });
    }
    projectList = new List<AboutDetail>.from([]);
    if (json['projectList'] != null) {
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
  bool enabled = true;

  AboutDetail({this.startDate, this.endDate, this.contents = "", this.enabled = true});

  AboutDetail.fromJson(Map<String, dynamic> json) {
    startDate = DateTime.parse(json['startDate']);
    endDate = json['endDate'] == null ? null : DateTime.parse(json['endDate']);
    contents = json['contents'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startDate'] = this.startDate!.toIso8601String();
    data['endDate'] = this.endDate == null ? "" : this.endDate!.toIso8601String();
    data['contents'] = this.contents;
    data['enabled'] = this.enabled;
    return data;
  }
}
