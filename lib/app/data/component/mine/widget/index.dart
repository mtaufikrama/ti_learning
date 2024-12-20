import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/colors.dart';
import '../function/function.dart';
import 'package:path/path.dart' as p;

import 'gif.dart';
import 'image.dart';
import 'svg.dart';
import 'video.dart';

class MyWidget {
  static Padding textField({
    TextEditingController? controller,
    String? title,
    String? hintText,
    Iterable<String>? autofillHints,
    bool? readOnly,
    int? maxLength,
    int? maxLines = 1,
    bool mandatory = false,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool? obscureText,
    IconData? iconPrefix,
    IconData? iconSuffix,
    bool autofocus = false,
    List<TextInputFormatter>? inputFormatters,
    void Function(String value)? onChanged,
    void Function()? onEditingComplete,
    void Function()? onSuffix,
    void Function()? onPrefix,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Text(
                  "$title${mandatory ? " *" : ""}",
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                )
              : Container(),
          TextFormField(
            controller: controller,
            autofocus: autofocus,
            autofillHints: autofillHints,
            validator: validator,
            readOnly: readOnly ?? false,
            maxLength: maxLength,
            onEditingComplete: onEditingComplete,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType,
            maxLines: maxLines,
            style: TextStyle(
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: MyColor.primer,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              suffixIcon: onSuffix != null || iconSuffix != null
                  ? IconButton(
                      onPressed: onSuffix,
                      icon: Icon(
                        iconSuffix,
                      ),
                    )
                  : null,
              prefixIcon: onPrefix != null || iconPrefix != null
                  ? IconButton(
                      onPressed: onPrefix,
                      icon: Icon(
                        iconPrefix,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  static Widget media(
    dynamic mediaSource, {
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
    ExtendedImageMode mode = ExtendedImageMode.none,
  }) {
    String extension = '';

    if (mediaSource is String) {
      extension = p.extension(mediaSource).toLowerCase();
      if (extension.isEmpty) {
        extension = p.extension(p.toUri(mediaSource).path).toLowerCase();
      }
    } else if (mediaSource is XFile) {
      extension = p.extension(mediaSource.path).toLowerCase();
      if (extension.isEmpty) {
        extension = MyFX.getExtensionFromMimeType(mediaSource.mimeType ?? '');
      }
    } else if (mediaSource is File) {
      extension = p.extension(mediaSource.path).toLowerCase();
    } else if (mediaSource is Uint8List) {
      extension = MyFX.getExtensionFromUint8List(mediaSource);
    } else {
      extension = '';
    }
    print('extension : $extension');
    return mediaFromExtension(
      mediaSource,
      ext: extension,
      fit: fit,
      width: width,
      height: height,
      mode: mode,
    );
  }

  static Padding submit({
    required String text,
    IconData? icon,
    Color? color,
    required void Function()? onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: icon == null
          ? ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(backgroundColor: color),
              child: Text(text),
            )
          : ElevatedButton.icon(
              icon: Icon(icon),
              onPressed: onPressed,
              label: Text(text),
            ),
    );
  }

  static FutureBuilder<T> future<T>({
    required Future<T>? future,
    required Widget Function(BuildContext context, T? data) builder,
    Widget Function(BuildContext context)? processBuilder,
  }) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState != ConnectionState.waiting &&
            snapshot.data != null) {
          return builder(context, snapshot.data);
        } else {
          return processBuilder != null
              ? processBuilder(context)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        }
      },
    );
  }

  static Widget mediaFromExtension(
    dynamic mediaSource, {
    required String ext,
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
    ExtendedImageMode mode = ExtendedImageMode.none,
  }) {
    if (['.jpg', '.jpeg', '.png', ''].contains(ext)) {
      return MyImageWidget(
        imageSource: mediaSource,
        fit: fit,
        width: width,
        height: height,
        mode: mode,
      );
    } else if (['.mp4', '.avi', '.mov', '.mkv'].contains(ext)) {
      return MyVideoWidget(videoSource: mediaSource);
    } else if (['.svg'].contains(ext)) {
      return MySVGWidget(
        svgSource: mediaSource,
        fit: fit,
        width: width,
        height: height,
      );
    } else if (['.gif'].contains(ext)) {
      return MyGIFWidget(
        gifSource: mediaSource,
        fit: fit,
        width: width,
        height: height,
      );
    } else {
      return MyImageWidget(
        imageSource: mediaSource,
        fit: fit,
        width: width,
        height: height,
        mode: mode,
      );
    }
  }
}
