import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/insight_premium_audio_controller.dart';

class InsightPremiumAudioView extends GetView<InsightPremiumAudioController> {
  const InsightPremiumAudioView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InsightPremiumAudioView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'InsightPremiumAudioView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
