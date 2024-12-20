import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ti_learning/app/modules/home/views/home_subview.dart';
import 'package:ti_learning/app/routes/app_pages.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final selectedIndex = 0.obs;
  static const optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final widgetOptions = [
    const HomeSubView(),
    const Text(
      'Index 1: Courses',
      style: optionStyle,
    ),
    const Text(
      'Index 2: Profile',
      style: optionStyle,
    ),
  ];

  void onItemTapped(int value) {
    selectedIndex.value = value;
    if (value == 1) {
      selectedIndex.value = 0;
      Get.toNamed(Routes.COURSES);
    }
  }
}
