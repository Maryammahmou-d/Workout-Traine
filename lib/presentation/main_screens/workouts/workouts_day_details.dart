import 'package:flutter/material.dart';
import 'package:gym/models/workout_details_model.dart';
import 'package:gym/shared/widgets/shared_widgets.dart';

import '../../../shared/widgets/navigation_card.dart';
import '../../../style/colors.dart';

class WorkoutsOfTheDayScreen extends StatelessWidget {
  const WorkoutsOfTheDayScreen({
    super.key,
    required this.workouts,
    required this.day,
  });
  final List<Workout> workouts;
  final String day;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultContainerWithAppBar(
          screenTitle: day,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height - 185,
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 20),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Hero(
                  tag: index == 0 ? "Stretching" : "Stretching$index",
                  child: NavigationCard(
                    isWithDesc: false,
                    setName: workouts[index].title,
                    imgUrl: workouts[index].imageUrl,
                    onTap: () {
                      // Navigate(
                      //   screen: WorkoutDetails(
                      //     workoutDetails: workouts[index],
                      //   ),
                      //   context: context,
                      // ).to();
                    },
                    numOfWorkouts: '',
                  ),
                ),
                separatorBuilder: (context, index) => const Divider(
                  height: 32,
                  thickness: 1,
                  color: AppColors.lightGrey,
                ),
                itemCount: workouts.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
