import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class MyVideoWidget extends StatefulWidget {
  final dynamic videoSource;

  const MyVideoWidget({
    super.key,
    required this.videoSource,
  });

  @override
  State<MyVideoWidget> createState() => _MyVideoWidgetState();
}

class _MyVideoWidgetState extends State<MyVideoWidget> {
  VideoPlayerController? _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    super.initState();
    if (_controller != null) {
      _controller!.dispose();
    }
    if (widget.videoSource is String) {
      if (widget.videoSource.startsWith('http')) {
        _controller =
            VideoPlayerController.networkUrl(Uri.parse(widget.videoSource));
      } else if (widget.videoSource.startsWith('asset')) {
        _controller = VideoPlayerController.asset(widget.videoSource);
      } else {
        _controller = VideoPlayerController.file(File(widget.videoSource));
      }
    } else if (widget.videoSource is XFile) {
      if (GetPlatform.isWeb || GetPlatform.isDesktop) {
        _controller = VideoPlayerController.networkUrl(
            Uri.parse(widget.videoSource.path));
      } else {
        final File videoFile = File(widget.videoSource.path);
        _controller = VideoPlayerController.file(videoFile);
      }
    } else if (widget.videoSource is File) {
      if (GetPlatform.isWeb) {
        _controller =
            VideoPlayerController.networkUrl((widget.videoSource as File).uri);
      } else {
        _controller = VideoPlayerController.file(widget.videoSource);
      }
    } else {
      _controller = VideoPlayerController.networkUrl(widget.videoSource);
    }
    _initializeVideoPlayerFuture = _controller!.initialize().then(
      (value) {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _controller!.value.isPlaying
                  ? _controller!.pause()
                  : _controller!.play();
            });
          },
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        !_controller!.value.isPlaying
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _controller!.play();
                  });
                },
                icon: Icon(
                  _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              )
            : IconButton(
                onPressed: () {
                  setState(() {
                    _controller!.pause();
                  });
                },
                icon: Icon(
                  _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              )
      ],
    );
  }
}
