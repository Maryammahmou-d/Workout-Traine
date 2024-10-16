import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/workouts/workouts_cubit.dart';
import 'package:gym/presentation/main_screens/workouts/cache_video_screen.dart';
import 'package:gym/presentation/main_screens/workouts/workout_details/workout_details.dart';
import 'package:gym/shared/extentions.dart';
import 'package:gym/shared/widgets/snackbar.dart';

import '../../../shared/constants.dart';
import '../../../shared/navigate_functions.dart';
import '../../../shared/widgets/navigation_card.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../../../style/colors.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocProvider(
        create: (context) => WorkoutsCubit()..gettingWorkoutsPlan(),
        child: SafeArea(
          child: SizedBox(
            height: AppConstants.screenSize(context).height,
            child: Stack(
              children: [
                DefaultAppBarWithRadius(
                  screenTitle: "workouts".getLocale(context),
                  withBackArrow: false,
                  prefixIcon: BlocBuilder<WorkoutsCubit, WorkoutsState>(
                      builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        Navigate(
                          context: context,
                          screen: CacheAllVideosScreen(
                            workoutsCubit: context.read<WorkoutsCubit>(),
                          ),
                        ).to();
                      },
                      icon: const Icon(
                        Icons.slow_motion_video_outlined,
                        color: Colors.white,
                      ),
                    );
                  }),
                  suffixIcon: BlocBuilder<WorkoutsCubit, WorkoutsState>(
                    builder: (context, state) {
                      return state is GettingWorkoutsPlanLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                context
                                    .read<WorkoutsCubit>()
                                    .gettingWorkoutsPlan(isRefreshPlans: true);
                              },
                              icon: const Icon(Icons.refresh_rounded),
                            );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  margin: const EdgeInsets.only(top: 70.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: BlocConsumer<WorkoutsCubit, WorkoutsState>(
                    listener: (context, state) {
                      if (state is GettingWorkoutsPlanErrorState) {
                        defaultErrorSnackBar(
                            context: context, message: state.errMsg);
                      }
                    },
                    builder: (context, state) {
                      return state is GettingWorkoutsPlanLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : context
                                  .read<WorkoutsCubit>()
                                  .workoutsPlan
                                  .isNotEmpty
                              ? ListView.separated(
                                  padding: const EdgeInsets.only(
                                    bottom: 20,
                                    left: 20,
                                    right: 20,
                                  ),
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Hero(
                                      tag: context
                                          .read<WorkoutsCubit>()
                                          .workoutsPlan
                                          .keys
                                          .elementAt(index),
                                      child: NavigationCard(
                                        setName:
                                            convertBackendDayToFormattedDay(
                                                context
                                                    .read<WorkoutsCubit>()
                                                    .workoutsPlan
                                                    .keys
                                                    .elementAt(index)),
                                        numOfWorkouts:
                                            "${context.read<WorkoutsCubit>().workoutsPlan.values.elementAt(index).length} ${"workouts".getLocale(context)}",
                                        imgUrl: context
                                                .read<WorkoutsCubit>()
                                                .workoutsPlan
                                                .values
                                                .elementAt(index)
                                                .isNotEmpty
                                            ? context
                                                .read<WorkoutsCubit>()
                                                .workoutsPlan
                                                .values
                                                .elementAt(index)
                                                .first
                                                .cover
                                            : "",
                                        onTap: () {
                                          Navigate(
                                            screen: WorkoutDetails(
                                              workoutsCubit:
                                                  context.read<WorkoutsCubit>(),
                                              workoutDetails: context
                                                  .read<WorkoutsCubit>()
                                                  .workoutsPlan
                                                  .values
                                                  .elementAt(index)
                                                  .first,
                                              allExercises: context
                                                  .read<WorkoutsCubit>()
                                                  .workoutsPlan
                                                  .values
                                                  .elementAt(index),
                                            ),
                                            context: context,
                                          ).to();
                                        },
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    height: 32,
                                    thickness: 1,
                                    color: AppColors.lightGrey,
                                  ),
                                  itemCount: context
                                      .read<WorkoutsCubit>()
                                      .workoutsPlan
                                      .length,
                                )
                              : const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String convertBackendDayToFormattedDay(String backendDay) {
  // Extract numeric part from the backend day string
  String numericPart = backendDay.replaceAll(RegExp(r'[^0-9]'), '');

  // Convert the numeric part to an integer
  int dayNumber = int.tryParse(numericPart) ?? 0;

  // Create the formatted day string
  String formattedDay = 'Day $dayNumber';

  return formattedDay;
}
