import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:image_picker/image_picker.dart';

class MyGIFWidget extends StatefulWidget {
  final dynamic gifSource;
  final BoxFit fit;
  final double? width;
  final double? height;

  const MyGIFWidget({
    super.key,
    required this.gifSource,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  State<MyGIFWidget> createState() => _MyGIFWidgetState();
}

class _MyGIFWidgetState extends State<MyGIFWidget>
    with TickerProviderStateMixin {
  late final GifController gifController;

  @override
  void initState() {
    gifController = GifController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.gifSource is String) {
      if (widget.gifSource.startsWith('http')) {
        return Gif(
          controller: gifController,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          duration: const Duration(seconds: 20),
          autostart: Autostart.once,
          placeholder: (context) =>
              const Center(child: CircularProgressIndicator()),
          image: NetworkImage(
            widget.gifSource,
          ),
        );
      } else if (widget.gifSource.startsWith('assets')) {
        return Gif(
          controller: gifController,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          duration: const Duration(seconds: 20),
          autostart: Autostart.once,
          placeholder: (context) =>
              const Center(child: CircularProgressIndicator()),
          image: AssetImage(
            widget.gifSource,
          ),
        );
      } else {
        if (GetPlatform.isWeb) {
          return Gif(
            controller: gifController,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            duration: const Duration(seconds: 20),
            autostart: Autostart.once,
            placeholder: (context) =>
                const Center(child: CircularProgressIndicator()),
            image: NetworkImage(
              widget.gifSource,
            ),
          );
        } else {
          return Gif(
            controller: gifController,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            duration: const Duration(seconds: 20),
            autostart: Autostart.once,
            placeholder: (context) =>
                const Center(child: CircularProgressIndicator()),
            image: MemoryImage(
              File(widget.gifSource).readAsBytesSync(),
            ),
          );
        }
      }
    } else if (widget.gifSource is XFile) {
      if (GetPlatform.isWeb) {
        return Gif(
          controller: gifController,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          duration: const Duration(seconds: 20),
          autostart: Autostart.once,
          placeholder: (context) =>
              const Center(child: CircularProgressIndicator()),
          image: NetworkImage(
            widget.gifSource.path,
          ),
        );
      } else {
        return Gif(
          controller: gifController,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          duration: const Duration(seconds: 20),
          autostart: Autostart.once,
          placeholder: (context) =>
              const Center(child: CircularProgressIndicator()),
          image: MemoryImage(File(widget.gifSource.path).readAsBytesSync()),
        );
      }
    } else if (widget.gifSource is File) {
      return Gif(
        controller: gifController,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        duration: const Duration(seconds: 20),
        autostart: Autostart.once,
        placeholder: (context) =>
            const Center(child: CircularProgressIndicator()),
        image: MemoryImage(
          widget.gifSource.readAsBytesSync(),
        ),
      );
    } else if (widget.gifSource is Uint8List) {
      return Gif(
        controller: gifController,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        duration: const Duration(seconds: 20),
        autostart: Autostart.once,
        placeholder: (context) =>
            const Center(child: CircularProgressIndicator()),
        image: MemoryImage(
          widget.gifSource,
        ),
      );
    } else {
      return const Icon(Icons.error);
    }
  }
}
