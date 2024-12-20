class ChapterModel {
  String? sId;
  List<CoursesId>? coursesId;
  String? createdAt;
  List<CoursesId>? lesson;
  String? title;

  ChapterModel(
      {this.sId, this.coursesId, this.createdAt, this.lesson, this.title});

  ChapterModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['coursesId'] != null) {
      coursesId = <CoursesId>[];
      json['coursesId'].forEach((v) {
        coursesId!.add(CoursesId.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    if (json['lesson'] != null) {
      lesson = <CoursesId>[];
      json['lesson'].forEach((v) {
        lesson!.add(CoursesId.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (coursesId != null) {
      data['coursesId'] = coursesId!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    if (lesson != null) {
      data['lesson'] = lesson!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    return data;
  }
}

class CoursesId {
  String? sId;
  String? title;

  CoursesId({this.sId, this.title});

  CoursesId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    return data;
  }
}
