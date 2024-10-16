import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/tracking/tracking_cubit.dart';
import 'package:gym/presentation/main_screens/tracking/tracking_widgets.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/shared/extentions.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../models/workout_details_model.dart';
import '../../../shared/widgets/snack_bar_widget.dart';
import '../../../style/colors.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocProvider(
        create: (context) => TrackingCubit()..loadSelectedWorkouts(),
        child: SafeArea(
          child: SizedBox(
            height: AppConstants.screenSize(context).height,
            child: Stack(
              children: [
                const TrackingHeader(),
                Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                  ),
                  margin: const EdgeInsets.only(top: 180.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: BlocBuilder<TrackingCubit, TrackingState>(
                    buildWhen: (previous, current) =>
                        current is ChangeSelectedDayState ||
                        current is ChangeWorkoutOpeningState ||
                        current is ChangeSetDoneState ||
                        current is DeleteSetState ||
                        current is AddNewSetState ||
                        current is SelectWorkoutsState,
                    builder: (context, selectedDay) {
                      final TrackingCubit trackingCubit =
                          context.read<TrackingCubit>();
                      bool isEmpty = trackingCubit.selectedWorkouts.isEmpty;
                      return isEmpty
                          ? Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: AppColors.white,
                                  textStyle: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.white,
                                      ),
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        width: AppConstants.screenSize(context)
                                            .width,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 20),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'selectDayFromYourPlan'
                                                  .getLocale(context),
                                              style: AppConstants.textTheme(
                                                      context)
                                                  .titleSmall,
                                            ),
                                            const SizedBox(
                                              height: 24,
                                            ),
                                            ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    trackingCubit.selectWorkouts(AppConstants
                                                                .workoutsRepository
                                                                .workoutsPlan[
                                                            AppConstants
                                                                .workoutsRepository
                                                                .workoutsPlan
                                                                .keys
                                                                .elementAt(
                                                                    index)] ??
                                                        []);
                                                    Navigator.pop(context);
                                                  },
                                                  child: SizedBox(
                                                    height: 20,
                                                    child: Text(
                                                      AppConstants
                                                          .workoutsRepository
                                                          .workoutsPlan
                                                          .keys
                                                          .elementAt(index),
                                                    ),
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const Divider(
                                                height: 32,
                                                color: AppColors.lightGrey,
                                              ),
                                              itemCount: AppConstants
                                                  .workoutsRepository
                                                  .workoutsPlan
                                                  .values
                                                  .length,
                                            )

                                            // InkWell(
                                            //   onTap: () {
                                            //     trackingCubit.selectWorkouts(dummyWorkoutPlan[0].workouts);
                                            //     Navigator.pop(context);
                                            //   },
                                            //   child: SizedBox(
                                            //     height: 20,
                                            //     child: Text(
                                            //       dummyWorkoutPlan[0].workoutDay,
                                            //     ),
                                            //   ),
                                            // ),
                                            // const Divider(
                                            //   height: 32,
                                            //   color: AppColors.lightGrey,
                                            // ),
                                            // InkWell(
                                            //   onTap: () {
                                            //     trackingCubit.selectWorkouts(dummyWorkoutPlan[1].workouts);
                                            //     Navigator.pop(context);
                                            //   },
                                            //   child: SizedBox(
                                            //     height: 20,
                                            //     child: Text(
                                            //       dummyWorkoutPlan[1].workoutDay,
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text("startWorkout".getLocale(context)),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemCount: trackingCubit.selectedWorkouts.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: AppColors.lightGrey,
                                height: 32,
                              ),
                              itemBuilder: (context, index) {
                                TrackWorkout workout =
                                    trackingCubit.selectedWorkouts[index];
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        trackingCubit
                                            .changeWorkoutOpenState(index);
                                      },
                                      child: SizedBox(
                                        width: AppConstants.screenSize(context)
                                                .width -
                                            40,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                workout.title,
                                                style: AppConstants.textTheme(
                                                        context)
                                                    .titleMedium!
                                                    .copyWith(
                                                      color: AppColors.black,
                                                    ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Icon(
                                              workout.isOpen
                                                  ? Icons
                                                      .keyboard_arrow_up_rounded
                                                  : Icons
                                                      .keyboard_arrow_down_rounded,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      padding: const EdgeInsets.only(
                                          top: 16, bottom: 20),
                                      height: workout.isOpen ? null : 0,
                                      child: Column(
                                        children: [
                                          ListView.separated(
                                            itemCount:
                                                workout.lbsAndReps.length,
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(height: 12),
                                            itemBuilder: (context, repsIndex) =>
                                                Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 45,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "set"
                                                            .getLocale(context),
                                                        style: AppConstants
                                                                .textTheme(
                                                                    context)
                                                            .bodyLarge!
                                                            .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                      ),
                                                      const SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        '${repsIndex + 1}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppConstants
                                                                .textTheme(
                                                                    context)
                                                            .bodyLarge!
                                                            .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(),
                                                // const SizedBox(
                                                //   width: 20,
                                                // ),
                                                SizedBox(
                                                  width: 80,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "kg".getLocale(context),
                                                        style: AppConstants
                                                                .textTheme(
                                                                    context)
                                                            .bodyLarge!
                                                            .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                      ),
                                                      LbsAndRepsValue(
                                                        workoutIndex: index,
                                                        index: repsIndex,
                                                        value: workout
                                                            .lbsAndReps[
                                                                repsIndex]
                                                            .lbs,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 80,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "reps"
                                                            .getLocale(context),
                                                        style: AppConstants
                                                                .textTheme(
                                                                    context)
                                                            .bodyLarge!
                                                            .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                      ),
                                                      LbsAndRepsValue(
                                                        isLbs: false,
                                                        workoutIndex: index,
                                                        index: repsIndex,
                                                        value: workout
                                                            .lbsAndReps[
                                                                repsIndex]
                                                            .reps,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Spacer(
                                                  flex: 2,
                                                ),
                                                SizedBox(
                                                  width: 80,
                                                  height: 70,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          trackingCubit
                                                              .addNewSet(
                                                            index,
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 45,
                                                          width: 60,
                                                          color: workout
                                                                  .lbsAndReps[
                                                                      repsIndex]
                                                                  .isDone
                                                              ? AppColors
                                                                  .mainColor
                                                              : AppColors
                                                                  .lightGrey,
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.add,
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // const SizedBox(
                                          //   height: 28,
                                          // ),
                                          // Row(
                                          //   children: <Widget>[
                                          //     SizedBox(
                                          //       width: (AppConstants.screenSize(
                                          //                       context)
                                          //                   .width -
                                          //               56) /
                                          //           2,
                                          //       child: ElevatedButton.icon(
                                          //         style: ElevatedButton.styleFrom(
                                          //           backgroundColor: Colors.white,
                                          //           shape: RoundedRectangleBorder(
                                          //             borderRadius:
                                          //                 BorderRadius.circular(
                                          //                     8.0),
                                          //           ),
                                          //         ),
                                          //         onPressed: () {
                                          //           trackingCubit
                                          //               .deleteSet(index);
                                          //         },
                                          //         icon: const Icon(Icons.remove),
                                          //         label: const Text("Delete Set"),
                                          //       ),
                                          //     ),
                                          //     const SizedBox(width: 16),
                                          //     SizedBox(
                                          //       width: (AppConstants.screenSize(
                                          //                       context)
                                          //                   .width -
                                          //               56) /
                                          //           2,
                                          //       child: ElevatedButton.icon(
                                          //         style: ElevatedButton.styleFrom(
                                          //           backgroundColor: Colors.white,
                                          //           shape: RoundedRectangleBorder(
                                          //             borderRadius:
                                          //                 BorderRadius.circular(
                                          //                     8.0),
                                          //           ),
                                          //         ),
                                          //         onPressed: () {
                                          //           showAddSetDialog(context,
                                          //               index, trackingCubit);
                                          //         },
                                          //         icon: const Icon(Icons.add),
                                          //         label: const Text("Add Set"),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
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

class TrackingHeader extends StatelessWidget {
  const TrackingHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      color: AppColors.mainColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, top: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 38,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "trackMyWeightsAndReps".getLocale(context),
                      style:
                          AppConstants.textTheme(context).titleMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                    ),
                  ),
                  const SizedBox(),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: BlocBuilder<TrackingCubit, TrackingState>(
                      buildWhen: (previous, current) {
                        return current is UploadTrackToApiLoadingState ||
                            current is UploadTrackToApiErrorState ||
                            current is UploadTrackToApiSuccessState;
                      },
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            if (context
                                .read<TrackingCubit>()
                                .selectedWorkouts
                                .isNotEmpty) {
                              if (state is! UploadTrackToApiLoadingState) {
                                context.read<TrackingCubit>().uploadToApi(
                                      context,
                                    );
                              }
                            } else {
                              errorSnackBar(
                                context: context,
                                message: "You don't have a track to upload",
                              );
                            }
                          },
                          icon: state is UploadTrackToApiLoadingState
                              ? const Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(end: 16.0),
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                  ),
                                )
                              : const Icon(
                                  Icons.upload_rounded,
                                  color: AppColors.white,
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.center,
            //   child: Text(
            //     "trackMyWeightsAndReps".getLocale(context),
            //     style: AppConstants.textTheme(context)
            //         .titleMedium!
            //         .copyWith(
            //           fontWeight: FontWeight.w700,
            //           color: Colors.white,
            //         ),
            //   ),
            // ),
            const SizedBox(
              height: 18,
            ),
            BlocBuilder<TrackingCubit, TrackingState>(
              buildWhen: (previous, current) =>
                  current is ChangeSelectedDayState,
              builder: (context, selectedDay) {
                final TrackingCubit trackingCubit =
                    context.read<TrackingCubit>();
                return TableCalendar(
                  daysOfWeekHeight: 20,
                  headerStyle: const HeaderStyle(
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    weekendStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  headerVisible: false,
                  rowHeight: 80,
                  startingDayOfWeek: StartingDayOfWeek.saturday,
                  calendarStyle: CalendarStyle(
                    outsideDecoration: const BoxDecoration(
                      color: AppColors.oldMainColor,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: const TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 18,
                    ),
                    withinRangeTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    defaultTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    weekendTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    outsideTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    rangeHighlightColor: AppColors.mainColor,
                    todayDecoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.lightGrey,
                      ),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  selectedDayPredicate: (day) {
                    return isSameDay(trackingCubit.selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    trackingCubit.selectDate(selectedDay);
                  },
                  calendarFormat: CalendarFormat.week,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: trackingCubit.selectedDay,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
