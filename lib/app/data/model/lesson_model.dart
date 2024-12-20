import 'package:ti_learning/app/data/model/courses_model.dart';

class LessonModel {
  String? sId;
  String? createdAt;
  List<PathImage>? path;
  String? title;

  LessonModel({this.sId, this.createdAt, this.path, this.title});

  LessonModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    data['createdAt'] = createdAt;
    if (path != null) {
      data['path'] = path!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    return data;
  }
}
