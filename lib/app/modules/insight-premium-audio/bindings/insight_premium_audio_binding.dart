import 'package:get/get.dart';

import '../controllers/insight_premium_audio_controller.dart';

class InsightPremiumAudioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InsightPremiumAudioController>(
      () => InsightPremiumAudioController(),
    );
  }
}
