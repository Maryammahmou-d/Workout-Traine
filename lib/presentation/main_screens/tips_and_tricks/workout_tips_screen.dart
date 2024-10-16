import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/presentation/main_screens/tips_and_tricks/tips_tricks_details_screen.dart';
import 'package:gym/shared/extentions.dart';

import '../../../blocs/tips_cubit/tips_and_tricks_cubit.dart';
import '../../../shared/constants.dart';
import '../../../shared/navigate_functions.dart';
import '../../../shared/widgets/navigation_card.dart';
import '../../../shared/widgets/shared_widgets.dart';

class WorkoutTipsScreen extends StatelessWidget {
  const WorkoutTipsScreen({
    super.key,
    required this.tipsAndTricksCubit,
  });

  final TipsAndTricksCubit tipsAndTricksCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: tipsAndTricksCubit..workoutTipsScreenInit(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SizedBox(
            height: AppConstants.screenSize(context).height,
            width: AppConstants.screenSize(context).width,
            child: Stack(
              children: [
                 DefaultAppBarWithRadius(
                  screenTitle: "workout".getLocale(context),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 20,
                    right: 20,
                  ),
                  margin: const EdgeInsets.only(top: 70.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: BlocBuilder<TipsAndTricksCubit, TipsAndTricksState>(
                      buildWhen: (previous, current) =>
                          current is GetWorkoutsTipsLoadingState ||
                          current is GetWorkoutsTipsSuccessState ||
                          current is GetWorkoutsTipsErrorState,
                      builder: (context, state) {
                        return state is GetWorkoutsTipsLoadingState
                            ? const CircularProgressIndicator()
                            : state is GetWorkoutsTipsErrorState
                                ? const SizedBox()
                                : ListView.separated(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    itemBuilder: (context, index) =>
                                        NavigationCard(
                                      setName:
                                          tipsAndTricksCubit.workouts[index].name,
                                      numOfWorkouts: "",
                                      isWithDesc: false,
                                      imgUrl:
                                          tipsAndTricksCubit.workouts[index].cover,
                                      onTap: () {
                                        Navigate(
                                          context: context,
                                          screen: TipsAndTripsDetailsScreen(
                                            title: tipsAndTricksCubit
                                                .workouts[index].name,
                                            img: tipsAndTricksCubit
                                                .workouts[index].img,
                                            videoUrl: tipsAndTricksCubit
                                                .workouts[index].video,
                                          ),
                                        ).to();
                                      },
                                    ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 16,
                                    ),
                                    itemCount: tipsAndTricksCubit
                                        .workouts.length,
                                  );
                      },
                    ),
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
