import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ti_learning/app/data/component/mine/widget/index.dart';

import '../controllers/enroll_course_detail_controller.dart';

class EnrollCourseDetailView extends GetView<EnrollCourseDetailController> {
  const EnrollCourseDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyWidget.future(
        future: controller.onFuture,
        builder: (context, data) {
          final courseDetail = controller.courseDetail.value;
          return Column(
            children: [
              MyWidget.media(courseDetail.path!.first.url),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      courseDetail.title ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: Row(
                            children: [
                              const SizedBox(width: 5),
                              Image.asset(
                                'assets/category.png',
                                width: 10,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                courseDetail.category ?? '',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Created by ${courseDetail.author}",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            MyWidget.media('assets/language.png', width: 15),
                            const SizedBox(width: 5),
                            const Text(
                              "in English",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${courseDetail.chapter!.length} Chapter • ",
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                child: Row(
                  children: [
                    Obx(() {
                      return TextButton(
                        onPressed: () => controller.tabviewIndex.value = 0,
                        style: TextButton.styleFrom(
                          backgroundColor: controller.tabviewIndex.value == 0
                              ? Colors.grey[800]
                              : null,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Overviews",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
                    Obx(() {
                      return TextButton(
                        onPressed: () => controller.tabviewIndex.value = 1,
                        style: TextButton.styleFrom(
                          backgroundColor: controller.tabviewIndex.value == 1
                              ? Colors.grey[800]
                              : null,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Contents",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
                    Obx(() {
                      return TextButton(
                        onPressed: () => controller.tabviewIndex.value = 2,
                        style: TextButton.styleFrom(
                          backgroundColor: controller.tabviewIndex.value == 2
                              ? Colors.grey[800]
                              : null,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          "More Like This",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              ListView.builder(
                itemCount: controller.chapterDetail.length,
                itemBuilder: (context, index) {
                  final chapter = controller.chapterDetail[index];
                  return Column(
                    children: [
                      Text(
                        "Chapter ${index + 1}",
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        chapter.title ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
