import 'package:get/get.dart';

import '../controllers/enroll_course_detail_controller.dart';

class EnrollCourseDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnrollCourseDetailController>(
      () => EnrollCourseDetailController(),
    );
  }
}
