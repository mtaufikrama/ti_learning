import 'package:ti_learning/app/data/model/courses_model.dart';

class CourseDetailModel {
  String? sId;
  String? author;
  String? category;
  List<Chapter>? chapter;
  String? createdAt;
  List<PathImage>? path;
  String? title;

  CourseDetailModel(
      {this.sId,
      this.author,
      this.category,
      this.chapter,
      this.createdAt,
      this.path,
      this.title});

  CourseDetailModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'];
    category = json['category'];
    if (json['chapter'] != null) {
      chapter = <Chapter>[];
      json['chapter'].forEach((v) {
        chapter!.add(Chapter.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    if (json['path'] != null) {
      path = <PathImage>[];
      json['path'].forEach((v) {
        path!.add(PathImage.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['author'] = author;
    data['category'] = category;
    if (chapter != null) {
      data['chapter'] = chapter!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    if (path != null) {
      data['path'] = path!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    return data;
  }
}

class Chapter {
  String? sId;
  String? title;

  Chapter({this.sId, this.title});

  Chapter.fromJson(Map<String, dynamic> json) {
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