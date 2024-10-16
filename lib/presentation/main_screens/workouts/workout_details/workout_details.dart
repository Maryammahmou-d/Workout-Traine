import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/workouts/workouts_cubit.dart';
import 'package:gym/models/workouts_plan_model.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/shared/extentions.dart';

import '../../../../shared/navigate_functions.dart';
import '../../../../shared/widgets/navigation_card.dart';
import '../../../../shared/widgets/snack_bar_widget.dart';
import '../../../../shared/widgets/video_player.dart';
import '../../../../style/colors.dart';

class WorkoutDetails extends StatefulWidget {
  const WorkoutDetails({
    super.key,
    required this.workoutDetails,
    required this.allExercises,
    required this.workoutsCubit,
  });
  final WorkoutsCubit workoutsCubit;
  final ExerciseModel workoutDetails;
  final List<ExerciseModel> allExercises;

  @override
  State<WorkoutDetails> createState() => _WorkoutDetailsState();
}

class _WorkoutDetailsState extends State<WorkoutDetails> {
  bool isLoadingVideo = true;
  late VideoPlayerController videoPlayerController;

  List<String> buttonTexts = [
    'exercise',
    'howToDo',
    'mistakes',
  ];
  List<String> videoLinks = [];

  @override
  void initState() {
    videoLinks = [
      widget.workoutDetails.video1,
      widget.workoutDetails.video2,
      widget.workoutDetails.video3,
    ];

    _initializeVideo(videoLinks[0]);
    super.initState();
  }

  Future<void> _initializeVideo(String videoUrl,
      {bool isFromButton = false}) async {
    if (!isFromButton) {
      await Future.delayed(const Duration(seconds: 2));
    }
    try {
      bool isVideoCached = AppConstants.box.containsKey(videoUrl);
      if (!isVideoCached) {
        await _downloadAndCacheVideo(videoUrl);
        videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(videoUrl),
                videoPlayerOptions: VideoPlayerOptions(
                  allowBackgroundPlayback: false,
                  mixWithOthers: false,
                ))
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
              ..initialize().then((value) => setState(() {
                    isLoadingVideo = false;
                  }));
      } else {
        File file = File(AppConstants.box.get(videoUrl));
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
          ..initialize().then((value) => setState(() {
                isLoadingVideo = false;
              }));
      }
      if (context.mounted) {
        videoPlayerController.play();
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
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.dispose();
    }
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.workoutsCubit,
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: AppConstants.screenSize(context).height * .85,
                child: Stack(
                  children: [
                    BlocBuilder<WorkoutsCubit, WorkoutsState>(
                      buildWhen: (previous, current) =>
                          current is ChangeVideoIndexState,
                      builder: (context, state) {
                        return isLoadingVideo
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : videoPlayerController.value.isInitialized
                                ? Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      VideoPlayer(videoPlayerController),
                                      PlayPauseOverlay(
                                          controller: videoPlayerController),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: VideoProgressIndicator(
                                          videoPlayerController,
                                          allowScrubbing: true,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox();
                      },
                    ),
                    SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              right: 20.0,
                              top: 20.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: AppColors.oldMainColor,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: isLoadingVideo
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainColor,
                        ),
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              setState(() {
                                isLoadingVideo = true;
                              });
                              if (videoPlayerController.value.isPlaying) {
                                videoPlayerController.dispose();
                              }
                              await Future.delayed(const Duration(seconds: 2));
                              _initializeVideo(videoLinks[1],
                                  isFromButton: true);

                              String tempLink = videoLinks[0];
                              videoLinks[0] = videoLinks[1];
                              videoLinks[1] = tempLink;

                              String tempText = buttonTexts[0];
                              buttonTexts[0] = buttonTexts[1];
                              buttonTexts[1] = tempText;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: AppColors.black,
                              ),
                              child: Center(
                                child: Text(
                                  buttonTexts[1].getLocale(context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                isLoadingVideo = true;
                              });
                              if (videoPlayerController.value.isPlaying) {
                                videoPlayerController.dispose();
                              }

                              await Future.delayed(const Duration(seconds: 2));
                              _initializeVideo(videoLinks[2],
                                  isFromButton: true);

                              String tempLink = videoLinks[0];
                              videoLinks[0] = videoLinks[2];
                              videoLinks[2] = tempLink;

                              String tempText = buttonTexts[0];
                              buttonTexts[0] = buttonTexts[2];
                              buttonTexts[2] = tempText;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: AppColors.black,
                              ),
                              child: Center(
                                child: Text(
                                  buttonTexts[2].getLocale(context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20.0,
                  top: 20.0,
                  // bottom: 12,
                ),
                child: Text(
                  widget.workoutDetails.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.mainBlack,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "🔢",
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "sets&reps".getLocale(context),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.mainBlack,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const Spacer(),
                        Text(
                          widget.workoutDetails.setsReps,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.regularGrey,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 24,
                      color: AppColors.lightGrey,
                      thickness: 1,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "🏓",
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "equipment".getLocale(context),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.mainBlack,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            widget.workoutDetails.equipment,
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.regularGrey,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 24,
                      color: AppColors.lightGrey,
                      thickness: 1,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "📔",
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "description".getLocale(context),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.mainBlack,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            widget.workoutDetails.description,
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppColors.regularGrey,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 24,
                      color: AppColors.lightGrey,
                      thickness: 1,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "🦵",
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "focusZone".getLocale(context),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.mainBlack,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const Spacer(),
                        Text(
                          widget.workoutDetails.zone,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.regularGrey,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ...List.generate(widget.allExercises.length, (index) {
                return Hero(
                  tag: widget.allExercises[index].title,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(
                      top: 8,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: NavigationCard(
                      onTap: () {
                        if (widget.allExercises[index].id !=
                            widget.workoutDetails.id) {
                          Navigate(
                            context: context,
                            screen: WorkoutDetails(
                              workoutsCubit: widget.workoutsCubit,
                              allExercises: widget.allExercises,
                              workoutDetails: widget.allExercises[index],
                            ),
                          ).off();
                        }
                      },
                      setName: widget.allExercises[index].title,
                      numOfWorkouts: widget.allExercises[index].zone,
                      imgUrl: widget.allExercises[index].cover,
                      suffixWidget: widget.allExercises[index].id ==
                              widget.workoutDetails.id
                          ? Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                color: AppColors.oldMainColor,
                                shape: BoxShape.circle,
                              ),
                            )
                          : null,
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
