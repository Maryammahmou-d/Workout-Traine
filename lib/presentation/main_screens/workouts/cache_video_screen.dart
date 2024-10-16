import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/workouts/workouts_cubit.dart';
import 'package:gym/shared/constants.dart';

import '../../../shared/widgets/shared_widgets.dart';
import '../../../style/colors.dart';

class CacheAllVideosScreen extends StatelessWidget {
  const CacheAllVideosScreen({
    super.key,
    required this.workoutsCubit,
  });

  final WorkoutsCubit workoutsCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: workoutsCubit..getVideoLinksSeparately(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DefaultAppBarWithRadius(
                height: 70,
                screenTitle: "",
              ),
              BlocBuilder<WorkoutsCubit, WorkoutsState>(
                builder: (context, state) {
                  var blocWatch = context.watch<WorkoutsCubit>();
                  return state is GettingVideoLinksLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: workoutsCubit.allVideoLinksPerDay.entries
                              .map((entry) {
                            String day = entry.key;
                            List<String> videoLinks = entry.value;
                            return Padding(
                              padding: const EdgeInsetsDirectional.only(
                                top: 8.0,
                                start: 8.0,
                                bottom: 16.0,
                              ),
                              child: blocWatch.completedDays.contains(day)
                                  ? Text(
                                      '$day (${videoLinks.length})',
                                      style: AppConstants.textTheme(context)
                                          .titleSmall!
                                          .copyWith(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w700,
                                          ),
                                      textAlign: TextAlign.start,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '$day (${videoLinks.length})',
                                          style: AppConstants.textTheme(context)
                                              .titleSmall!
                                              .copyWith(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                        if ((state is GettingAllVideosFromCacheLoadingState &&
                                                state.day == entry.key) ||
                                            (state is CachedDayVideoState &&
                                                state.day == entry.key))
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(end: 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "${blocWatch.currentDownloadingIndex} of ${videoLinks.length}",
                                                  style: const TextStyle(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                CircularProgressIndicator(
                                                  value: blocWatch
                                                          .currentDownloadingIndex /
                                                      videoLinks.length,
                                                ),
                                              ],
                                            ),
                                          ),
                                        if (!((state
                                                    is GettingAllVideosFromCacheLoadingState &&
                                                state.day == entry.key) ||
                                            (state is CachedDayVideoState &&
                                                state.day == entry.key)))
                                          IconButton(
                                            onPressed: () {
                                              workoutsCubit.cacheAllVideos(
                                                  videoLinks, entry.key);
                                            },
                                            icon: const Icon(
                                              Icons.download,
                                              color: AppColors.mainColor,
                                            ),
                                          ),
                                      ],
                                    ),
                            );
                          }).toList(),
                        );
                },
              ),
              BlocBuilder<WorkoutsCubit, WorkoutsState>(
                buildWhen: (previous, current) =>
                    current is GettingAllDaysVideosLoadingState ||
                    current is GettingAllDaysVideosSuccessState,
                builder: (context, state) {
                  return DefaultButton(
                    loading: state is GettingAllDaysVideosLoadingState,
                    color: AppColors.black,
                    function: () {
                      if(state is! GettingAllDaysVideosLoadingState) {
                        context.read<WorkoutsCubit>().downloadAllDaysVideos();
                      }
                    },
                    text: "Download All",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
