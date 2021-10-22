class AboutModel {
  String name = "";
  String email = "";
  String phoneNo = "";
  int career = 0;
  List<AboutDetail> careerList = [];
  List<AboutDetail> projectList = [];
  List<TechStack> stackList = [];

  AboutModel({
    this.name = "",
    this.email = "",
    this.phoneNo = "",
    this.career = 0,
    List<AboutDetail>? careerList,
    List<AboutDetail>? projectList,
    List<TechStack>? stackList,
  })  : careerList = careerList ?? [],
        projectList = projectList ?? [],
        stackList = stackList ?? [];

  AboutModel copyWith({
    String name = "",
    String email = "",
    String phoneNo = "",
    int career = 0,
    List<AboutDetail>? careerList,
    List<AboutDetail>? projectList,
    List<TechStack>? stackList,
  }) {
    return AboutModel(
        name: this.name,
        email: this.email,
        phoneNo: this.phoneNo,
        career: this.career,
        careerList: this.careerList,
        projectList: this.projectList,
        stackList: this.stackList);
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
    stackList = new List<TechStack>.from([]);
    if (json['stackList'] != null) {
      json['stackList'].forEach((v) {
        stackList.add(new TechStack.fromJson(v));
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
    data['stackList'] = this.stackList.map((v) => v.toJson()).toList();
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

class TechStack {
  String? stackCtg;
  String stackName = "";
  String? icon;
  int stackGuage = 0;
  bool enabled = true;

  TechStack({this.stackCtg, this.stackName = "", this.icon, this.stackGuage = 0, this.enabled = true});

  TechStack.fromJson(Map<String, dynamic> json) {
    stackCtg = json['stackCtg'];
    stackName = json['stackName'];
    stackGuage = json['stackGuage'] ?? 0;
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stackCtg'] = this.stackCtg;
    data['stackName'] = this.stackName;
    data['stackGuage'] = this.stackGuage;
    data['icon'] = this.icon;
    data['enabled'] = this.enabled;

    return data;
  }
}
