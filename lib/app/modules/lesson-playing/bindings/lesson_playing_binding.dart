import 'package:get/get.dart';

import '../controllers/lesson_playing_controller.dart';

class LessonPlayingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LessonPlayingController>(
      () => LessonPlayingController(),
    );
  }
}
