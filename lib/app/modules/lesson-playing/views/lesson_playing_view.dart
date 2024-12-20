import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lesson_playing_controller.dart';

class LessonPlayingView extends GetView<LessonPlayingController> {
  const LessonPlayingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LessonPlayingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LessonPlayingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
