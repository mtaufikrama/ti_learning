import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/component/api/index.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final obscurePass = true.obs;
  final isWeb = GetPlatform.isWeb;
  final form = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    passController.dispose();
    obscurePass.close();
    super.onClose();
  }

  void login() async {
    final validate = form.currentState!.validate();
    if (validate) {
      final user = await API.sign.login(
        pass: passController.text,
        email: emailController.text,
      );
      if (user.token != null) Get.offAllNamed(Routes.HOME);
    }
  }
}
