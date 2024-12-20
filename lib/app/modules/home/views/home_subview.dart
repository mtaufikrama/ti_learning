import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ti_learning/app/data/component/mine/constant/colors.dart';
import 'package:ti_learning/app/data/component/mine/widget/index.dart';
import 'package:ti_learning/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeSubView extends GetView<HomeController> {
  const HomeSubView({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              color: MyColor.primer,
              height: 100,
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            MyWidget.textField(
              iconPrefix: Icons.search,
              hintText: 'Courses, Insights or Events',
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                runAlignment: WrapAlignment.start,
                runSpacing: 20,
                spacing: 20,
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.COURSES),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: MyColor.primer,
                          child: Image.asset('assets/courses.png'),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Courses",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: MyColor.primer,
                          child: Image.asset('assets/audio_book.png'),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Audio Book",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
