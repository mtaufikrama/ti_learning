import 'package:ti_learning/app/data/model/chapter_model.dart';
import 'package:ti_learning/app/data/model/course_detail_model.dart';
import 'package:ti_learning/app/data/model/courses_model.dart';
import 'env.dart';
import 'index.dart';

class CoursesAPI {
  static const _baseUrl = Env.urlCourse;

  Future<List<CoursesModel>> get courses async {
    Map<String, dynamic> data = {};
    String lookup = r"$lookup";
    final response = await API.httpNetwork(
      url: _baseUrl,
      data: data,
      queryParameters: {lookup: "*"},
    );
    final obj =
        (response as List).map((e) => CoursesModel.fromJson(e)).toList();
    return obj;
  }

  Future<CourseDetailModel> coursesDetail(String id) async {
    Map<String, dynamic> data = {};
    String lookup = r"$lookup";
    final response = await API.httpNetwork(
      url: "$_baseUrl/$id",
      data: data,
      queryParameters: {lookup: "*"},
    );
    final obj = CourseDetailModel.fromJson(response);
    return obj;
  }

  Future<ChapterModel> chapterDetail(String id) async {
    Map<String, dynamic> data = {};
    String lookup = r"$lookup";
    final response = await API.httpNetwork(
      url: "${Env.urlChapter}/$id",
      data: data,
      queryParameters: {lookup: "*"},
    );
    final obj = ChapterModel.fromJson(response);
    return obj;
  }
}
