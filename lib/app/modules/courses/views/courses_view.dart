import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ti_learning/app/data/component/api/index.dart';
import 'package:ti_learning/app/data/component/mine/widget/index.dart';
import 'package:ti_learning/app/routes/app_pages.dart';

import '../controllers/courses_controller.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),
      body: Column(
        children: [
          MyWidget.textField(
            hintText: 'Title, mentor, or keywords..',
            iconPrefix: Icons.search,
            iconSuffix: Icons.filter_list,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("For You"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Recent"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Trending"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Technology"),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          const SizedBox(height: 10),
          MyWidget.future(
            future: API.courses.courses,
            builder: (context, data) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: data!.length,
                separatorBuilder: (context, index) => const Divider(
                  endIndent: 10,
                  indent: 10,
                ),
                itemBuilder: (context, index) {
                  final course = data[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed(
                        Routes.ENROLL_COURSE_DETAIL(course.sId ?? '')),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: MyWidget.media(
                                  course.path!.first.url ?? '',
                                  height: 100,
                                  width: 100),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course.title ?? '',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Image.network(
                                      "https://images.unsplash.com/flagged/photo-1559502867-c406bd78ff24?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=685&q=80",
                                      width: 10,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                        child: Text(
                                      course.author ?? '',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    )),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: const Color(0xFF17B8C1),
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: const EdgeInsets.all(2),
                                      child: const Text(
                                        "Beginner",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF17B8C1),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    MyWidget.media(
                                      'assets/language.png',
                                      width: 15,
                                    ),
                                    const SizedBox(width: 10)
                                  ],
                                ),
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
                                            course.category ?? '',
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
