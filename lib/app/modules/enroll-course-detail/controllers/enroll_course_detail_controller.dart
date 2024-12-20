import 'package:get/get.dart';
import 'package:ti_learning/app/data/component/api/index.dart';
import 'package:ti_learning/app/data/model/chapter_model.dart';
import 'package:ti_learning/app/data/model/course_detail_model.dart';

class EnrollCourseDetailController extends GetxController {
  //TODO: Implement EnrollCourseDetailController
  final coursesID = Get.parameters['id'] ?? '';
  final tabviewIndex = 0.obs;
  final courseDetail = CourseDetailModel().obs;
  final chapterDetail = [ChapterModel()].obs;

  Future<bool> get onFuture async {
    final a = await API.courses.coursesDetail(coursesID);
    courseDetail.value = a;
    final b = a.chapter!
        .map((e) async => await API.courses.chapterDetail(coursesID))
        .toList();
    final c = await Future.wait(b);
    chapterDetail.value = c;
    return true;
  }
}
