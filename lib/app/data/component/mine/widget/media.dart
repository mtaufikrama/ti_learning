import 'package:carousel_slider/carousel_slider.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class MyMediaView<T> extends StatelessWidget {
  const MyMediaView({
    super.key,
    required this.items,
    required this.item,
    required this.pathFile,
  });

  final List<T> items;
  final T item;
  final dynamic Function(T item) pathFile;

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () => Get.back(),
      direction: DismissiblePageDismissDirection.vertical,
      isFullScreen: false,
      child: CarouselSlider(
        options: CarouselOptions(
          enableInfiniteScroll: false,
          viewportFraction: 1,
          initialPage:
              item != null ? items.indexWhere((element) => element == item) : 1,
        ),
        items: items.map((content) {
          return Hero(
            tag: content as Object,
            child: MyWidget.media(
              pathFile(content),
              mode: ExtendedImageMode.gesture,
            ),
          );
        }).toList(),
      ),
    );
  }
}
