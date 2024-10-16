import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/food/food_cubit.dart';
import 'package:gym/shared/extentions.dart';
import 'package:gym/shared/navigate_functions.dart';
import 'package:gym/shared/widgets/navigation_card.dart';

import '../../../../shared/constants.dart';
import '../../../../shared/widgets/shared_widgets.dart';
import 'food_details_screen.dart';

class CookingRecipesScreen extends StatelessWidget {
  const CookingRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodCubit()..getCookingRecipesPlans(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SizedBox(
            height: AppConstants.screenSize(context).height,
            width: AppConstants.screenSize(context).width,
            child: Stack(
              children: [
                 DefaultAppBarWithRadius(
                  screenTitle: "cookingRecipes".getLocale(context),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  margin: const EdgeInsets.only(top: 70.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: BlocBuilder<FoodCubit, FoodState>(
                      builder: (context, state) {
                        FoodCubit foodCubit = context.read<FoodCubit>();
                        return state is GetCookingRecipesLoadingState
                            ? const CircularProgressIndicator()
                            : ListView.separated(
                                padding: const EdgeInsets.all(20),
                                itemBuilder: (context, index) {
                                  return Hero(
                                    tag:
                                        "recipes${foodCubit.cookingRecipes[index].id}",
                                    child: NavigationCard(
                                      setName:
                                          foodCubit.cookingRecipes[index].name,
                                      numOfWorkouts: "",
                                      imgUrl:
                                          foodCubit.cookingRecipes[index].img ??
                                              "",
                                      onTap: () {
                                        Navigate(
                                          context: context,
                                          screen: FoodDetailsScreen(
                                            recipesModel:
                                                foodCubit.cookingRecipes[index],
                                          ),
                                        ).to();
                                      },
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 16,
                                ),
                                itemCount: foodCubit.cookingRecipes.length,
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
