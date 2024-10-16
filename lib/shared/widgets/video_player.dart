import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:gym/shared/widgets/snack_bar_widget.dart';

import '../constants.dart';

class DefaultVideoPlayer extends StatefulWidget {
  const DefaultVideoPlayer({
    super.key,
    required this.videoUrl,
  });

  final String videoUrl;

  @override
  State<DefaultVideoPlayer> createState() => _DefaultVideoPlayerState();
}

class _DefaultVideoPlayerState extends State<DefaultVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  bool isLoadingVideo = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      bool isVideoCached = AppConstants.box.containsKey(widget.videoUrl);
      if (!isVideoCached) {
        await _downloadAndCacheVideo(widget.videoUrl);

        videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
              ..addListener(() {
                if (videoPlayerController.value.hasError) {
                  setState(() {
                    isLoadingVideo = false;
                  });
                  errorSnackBar(
                    message: "Error while loading video",
                    context: context,
                  );
                }
              })
              ..initialize().then((value) {
                setState(() {
                  isLoadingVideo = false;
                });
                videoPlayerController.play();
              });
      } else {
        File file = File(AppConstants.box.get(widget.videoUrl));
        videoPlayerController = VideoPlayerController.file(file)
          ..addListener(() {
            if (videoPlayerController.value.hasError) {
              setState(() {
                isLoadingVideo = false;
              });
              errorSnackBar(
                message: "Error while loading video",
                context: context,
              );
            }
          })
          ..initialize().then((value) {
            setState(() {
              isLoadingVideo = false;
            });
            videoPlayerController.play();
          });
      }
    } catch (e) {
      setState(() {
        isLoadingVideo = false;
      });
    }
  }

  Future<void> _downloadAndCacheVideo(String videoUrl) async {
    try {
      String filePath = "";
      if (Platform.isIOS) {
        List<Directory>? directories = await getExternalStorageDirectories(
            type: StorageDirectory.downloads);
        filePath = directories?.first.path ?? "";
        if (filePath.isEmpty) {
          final Directory appDocDir = await getApplicationDocumentsDirectory();
          filePath = '${appDocDir.path}/${videoUrl.split('/').last}';
        }
      } else {
        final Directory appDocDir = await getApplicationDocumentsDirectory();
        filePath = '${appDocDir.path}/${videoUrl.split('/').last}';
      }
      Dio dio = Dio();
      await dio.download(
        videoUrl,
        filePath,
      );
       File(filePath);

      await AppConstants.box.put(videoUrl, filePath);

      if (kDebugMode) {
        print("Finished caching $videoUrl");
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error downloading and caching video: $error");
      }
    }
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoadingVideo
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: videoPlayerController.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    VideoPlayer(videoPlayerController),
                    ControlsOverlay(controller: videoPlayerController),
                    VideoProgressIndicator(videoPlayerController,
                        allowScrubbing: true),
                  ],
                ),
              )
            : const SizedBox();
  }
}

class ControlsOverlay extends StatelessWidget {
  const ControlsOverlay({super.key, required this.controller});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}

class PlayPauseOverlay extends StatelessWidget {
  final VideoPlayerController controller;

  const PlayPauseOverlay({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    controller.value.isPlaying
                        ? controller.pause()
                        : controller.play();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
