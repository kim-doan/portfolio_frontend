class Pageable {
  int page = 0;
  int size = 10;

  Pageable({this.page = 0, this.size = 10});

  Pageable.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['size'] = this.size;
    return data;
  }
}
