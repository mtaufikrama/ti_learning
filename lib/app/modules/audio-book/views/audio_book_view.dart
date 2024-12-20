import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/audio_book_controller.dart';

class AudioBookView extends GetView<AudioBookController> {
  const AudioBookView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AudioBookView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AudioBookView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
