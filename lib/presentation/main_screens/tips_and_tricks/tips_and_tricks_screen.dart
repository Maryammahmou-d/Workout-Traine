import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/tips_cubit/tips_and_tricks_cubit.dart';
import 'package:gym/presentation/main_screens/tips_and_tricks/food_tips_screen.dart';
import 'package:gym/presentation/main_screens/tips_and_tricks/life_style_tips_screen.dart';
import 'package:gym/presentation/main_screens/tips_and_tricks/workout_tips_screen.dart';
import 'package:gym/shared/extentions.dart';
import 'package:gym/shared/navigate_functions.dart';
import 'package:gym/shared/widgets/navigation_card.dart';

import '../../../shared/constants.dart';
import '../../../shared/widgets/shared_widgets.dart';

class TipsAndTricksScreen extends StatelessWidget {
  const TipsAndTricksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TipsAndTricksCubit(),
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
                  screenTitle: "tipsAndTricks".getLocale(context),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  margin: const EdgeInsets.only(top: 70.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: BlocBuilder<TipsAndTricksCubit, TipsAndTricksState>(
                      builder: (context, state) {
                        TipsAndTricksCubit tipsAndTricksCubit =
                            context.read<TipsAndTricksCubit>();
                        return Column(
                          children: [
                            NavigationCard(
                              setName: "workout".getLocale(context),
                              numOfWorkouts: "",
                              isWithDesc: false,
                              imgUrl: "assets/images/workout_tips.jpg",
                              onTap: () {
                                Navigate(
                                    context: context,
                                    screen: WorkoutTipsScreen(
                                      tipsAndTricksCubit: tipsAndTricksCubit,
                                    )).to();
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: NavigationCard(
                                setName: "food".getLocale(context),
                                numOfWorkouts: "",
                                isWithDesc: false,
                                imgUrl: "assets/images/food_tips.jpg",
                                onTap: () {
                                  Navigate(
                                      context: context,
                                      screen: FoodTipsScreen(
                                        tipsAndTricksCubit: tipsAndTricksCubit,
                                      )).to();
                                },
                              ),
                            ),
                            NavigationCard(
                              setName: "lifeStyle".getLocale(context),
                              numOfWorkouts: "",
                              isWithDesc: false,
                              imgUrl: "assets/images/life_style_tips.jpg",
                              onTap: () {
                                Navigate(
                                    context: context,
                                    screen: LifeStyleTipsScreen(
                                      tipsAndTricksCubit: tipsAndTricksCubit,
                                    )).to();
                              },
                            ),
                          ],
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
