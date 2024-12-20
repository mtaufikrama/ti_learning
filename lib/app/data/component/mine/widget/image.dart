import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyImageWidget extends StatelessWidget {
  final dynamic
      imageSource; // Bisa berupa String (URL atau Asset), File, atau Uint8List (Memory Image)
  final BoxFit fit;
  final double? width;
  final double? height;
  final ExtendedImageMode mode;

  const MyImageWidget({
    super.key,
    required this.imageSource,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.mode = ExtendedImageMode.none,
  });

  @override
  Widget build(BuildContext context) {
    GestureConfig Function(ExtendedImageState)? initGestureConfigHandler =
        mode == ExtendedImageMode.gesture
            ? (state) => GestureConfig(
                  minScale: 0.9,
                  animationMinScale: 0.7,
                  maxScale: 3.0,
                  animationMaxScale: 3.5,
                  speed: 1.0,
                  inertialSpeed: 100.0,
                  initialScale: 1.0,
                  inPageView: false,
                  initialAlignment: InitialAlignment.center,
                )
            : null;

    EditorConfig? Function(ExtendedImageState?)? initEditorConfigHandler =
        mode == ExtendedImageMode.editor ? (state) => EditorConfig() : null;
    Widget loadStateChanged(ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          return Container();
        case LoadState.completed:
          return ExtendedRawImage(
            image: state.extendedImageInfo?.image,
            width: width,
            height: height,
            fit: fit,
          );
        case LoadState.failed:
          return Center(
            child: GestureDetector(
              child: const Icon(Icons.error),
              onTap: () => state.reLoadImage(),
            ),
          );
      }
    }

    if (imageSource is String) {
      if (imageSource.startsWith('http')) {
        return ExtendedImage.network(
          imageSource,
          width: width,
          height: height,
          fit: fit,
          cache: true,
          mode: mode,
          initEditorConfigHandler: initEditorConfigHandler,
          initGestureConfigHandler: initGestureConfigHandler,
          loadStateChanged: loadStateChanged,
        );
      } else if (imageSource.startsWith('assets')) {
        return ExtendedImage.asset(
          imageSource,
          width: width,
          height: height,
          fit: fit,
          mode: mode,
          initEditorConfigHandler: initEditorConfigHandler,
          initGestureConfigHandler: initGestureConfigHandler,
          loadStateChanged: loadStateChanged,
        );
      } else {
        if (GetPlatform.isWeb) {
          return ExtendedImage.network(
            imageSource,
            width: width,
            height: height,
            fit: fit,
            cache: true,
            mode: mode,
            initEditorConfigHandler: initEditorConfigHandler,
            initGestureConfigHandler: initGestureConfigHandler,
            loadStateChanged: loadStateChanged,
          );
        } else {
          return ExtendedImage.memory(
            File(imageSource).readAsBytesSync(),
            width: width,
            height: height,
            fit: fit,
            mode: mode,
            initEditorConfigHandler: initEditorConfigHandler,
            initGestureConfigHandler: initGestureConfigHandler,
            loadStateChanged: loadStateChanged,
          );
        }
      }
    } else if (imageSource is XFile) {
      if (GetPlatform.isWeb) {
        return ExtendedImage.network(
          imageSource.path,
          width: width,
          height: height,
          fit: fit,
          cache: true,
          mode: mode,
          initEditorConfigHandler: initEditorConfigHandler,
          initGestureConfigHandler: initGestureConfigHandler,
          loadStateChanged: loadStateChanged,
        );
      } else {
        return ExtendedImage.memory(
          File(imageSource.path).readAsBytesSync(),
          width: width,
          height: height,
          fit: fit,
          mode: mode,
          initEditorConfigHandler: initEditorConfigHandler,
          initGestureConfigHandler: initGestureConfigHandler,
          loadStateChanged: loadStateChanged,
        );
      }
    } else if (imageSource is File) {
      return ExtendedImage.memory(
        imageSource.readAsBytesSync(),
        width: width,
        height: height,
        fit: fit,
        mode: mode,
        initEditorConfigHandler: initEditorConfigHandler,
        initGestureConfigHandler: initGestureConfigHandler,
        loadStateChanged: loadStateChanged,
      );
    } else if (imageSource is Uint8List) {
      return ExtendedImage.memory(
        imageSource,
        width: width,
        height: height,
        fit: fit,
        mode: mode,
        initEditorConfigHandler: initEditorConfigHandler,
        initGestureConfigHandler: initGestureConfigHandler,
        loadStateChanged: loadStateChanged,
      );
    } else {
      return const Icon(Icons.error);
    }
  }
}
