import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MySVGWidget extends StatelessWidget {
  final dynamic svgSource;
  final BoxFit fit;
  final double? width;
  final double? height;

  const MySVGWidget({
    super.key,
    required this.svgSource,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    if (svgSource is String) {
      if (svgSource.startsWith('http')) {
        return SvgPicture.network(
          svgSource,
          placeholderBuilder: (context) => Container(
            padding: const EdgeInsets.all(30.0),
            child: const CircularProgressIndicator(),
          ),
          width: width,
          height: height,
          fit: fit,
        );
      } else if (svgSource.startsWith('assets')) {
        return SvgPicture.asset(
          svgSource,
          placeholderBuilder: (context) => Container(
            padding: const EdgeInsets.all(30.0),
            child: const CircularProgressIndicator(),
          ),
          width: width,
          height: height,
          fit: fit,
        );
      } else if (svgSource.startsWith('blob')) {
        return SvgPicture.network(
          svgSource,
          placeholderBuilder: (context) => Container(
            padding: const EdgeInsets.all(30.0),
            child: const CircularProgressIndicator(),
          ),
          width: width,
          height: height,
          fit: fit,
        );
      } else {
        if (GetPlatform.isWeb) {
          return SvgPicture.network(
            svgSource,
            placeholderBuilder: (context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: const CircularProgressIndicator(),
            ),
            width: width,
            height: height,
            fit: fit,
          );
        } else {
          return SvgPicture.memory(
            File(svgSource).readAsBytesSync(),
            placeholderBuilder: (context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: const CircularProgressIndicator(),
            ),
            width: width,
            height: height,
            fit: fit,
          );
        }
      }
    } else if (svgSource is XFile) {
      if (GetPlatform.isWeb) {
        return SvgPicture.network(
          svgSource.path,
          placeholderBuilder: (context) => Container(
            padding: const EdgeInsets.all(30.0),
            child: const CircularProgressIndicator(),
          ),
          width: width,
          height: height,
          fit: fit,
        );
      } else {
        return SvgPicture.memory(
          File(svgSource.path).readAsBytesSync(),
          placeholderBuilder: (context) => Container(
            padding: const EdgeInsets.all(30.0),
            child: const CircularProgressIndicator(),
          ),
          width: width,
          height: height,
          fit: fit,
        );
      }
    } else if (svgSource is File) {
      return SvgPicture.memory(
        svgSource.readAsBytesSync(),
        placeholderBuilder: (context) => Container(
          padding: const EdgeInsets.all(30.0),
          child: const CircularProgressIndicator(),
        ),
        width: width,
        height: height,
        fit: fit,
      );
    } else if (svgSource is Uint8List) {
      return SvgPicture.memory(
        svgSource,
        placeholderBuilder: (context) => Container(
          padding: const EdgeInsets.all(30.0),
          child: const CircularProgressIndicator(),
        ),
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      return const Icon(Icons.error);
    }
  }
}
