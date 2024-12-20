import 'package:get/get.dart';

import '../controllers/audio_book_controller.dart';

class AudioBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioBookController>(
      () => AudioBookController(),
    );
  }
}
