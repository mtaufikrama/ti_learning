import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:get/get.dart';
import 'package:ti_learning/app/data/component/mine/constant/colors.dart';
import 'package:ti_learning/app/routes/app_pages.dart';

import '../../../data/component/mine/widget/index.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: Form(
            key: controller.form,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo.png",
                  ),
                  MyWidget.textField(
                      autofillHints: [AutofillHints.username],
                      controller: controller.emailController,
                      validator: ValidationBuilder().build(),
                      title: 'E-mail',
                      hintText: 'Enter Work E-mail'),
                  Obx(() {
                    return MyWidget.textField(
                      autofillHints: [AutofillHints.password],
                      validator: ValidationBuilder().build(),
                      controller: controller.passController,
                      obscureText: controller.obscurePass.value,
                      onEditingComplete: controller.login,
                      title: 'Password',
                      hintText: 'Enter Password',
                      iconSuffix: controller.obscurePass.value
                          ? Icons.lock_outline_rounded
                          : Icons.lock_open_rounded,
                      onSuffix: () => controller.obscurePass.value =
                          !controller.obscurePass.value,
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: MyColor.primer,
                      ),
                      onPressed: controller.login,
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1, // Ketebalan garis
                            color: Colors.grey, // Warna garis
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Or",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () => Get.offAllNamed(Routes.HOME),
                      child: const Text(
                        'Explore without Login',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
