import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/food/food_cubit.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/shared/extentions.dart';

import '../../../shared/widgets/shared_widgets.dart';
import '../../../style/colors.dart';
import 'food_widgets.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodCubit()..getFoodPlansFromCache(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: SizedBox(
            height: AppConstants.screenSize(context).height,
            width: AppConstants.screenSize(context).width,
            child: Stack(
              // fit: StackFit.expand,
              children: [
                BlocBuilder<FoodCubit, FoodState>(
                  builder: (context, state) {
                    return DefaultAppBarWithRadius(
                      screenTitle: "foodDiary".getLocale(context),
                      suffixIcon: state is GetFoodPlansLoadingState
                          ? const CircularProgressIndicator(
                              color: AppColors.oldMainColor,
                            )
                          : IconButton(
                              onPressed: () {
                                context.read<FoodCubit>().getFoodPlans(
                                    userId:
                                        AppConstants.authRepository.user.id);
                              },
                              icon: const Icon(Icons.refresh_rounded),
                            ),
                    );
                  },
                ),
                BlocBuilder<FoodCubit, FoodState>(
                  builder: (context, state) {
                    FoodCubit foodCubit = context.read<FoodCubit>();
                    return Container(
                      padding: const EdgeInsets.only(top: 16),
                      margin: const EdgeInsets.only(top: 70.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: state is GetFoodPlansLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.oldMainColor,
                              ),
                            )
                          : SizedBox(
                              height: AppConstants.screenSize(context).height,
                              width: AppConstants.screenSize(context).width,
                              child: ListView.separated(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16)
                                        .copyWith(bottom: 16),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        foodCubit.foodPlans[index].planName,
                                        style: AppConstants.textTheme(context)
                                            .titleLarge!
                                            .copyWith(
                                              color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: foodCubit.foodPlans[index]
                                            .foodsForDays.values.length,
                                        itemBuilder: (context, listIndex) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Meal ${listIndex + 1}",
                                                style: AppConstants.textTheme(
                                                        context)
                                                    .titleMedium!
                                                    .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                      color: AppColors.black,
                                                    ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              ...foodCubit.foodPlans[index]
                                                  .foodsForDays.values
                                                  .toList()[listIndex]
                                                  .map((e) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 12.0),
                                                  child: FoodCard(meal: e),
                                                );
                                              }),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 16,
                                ),
                                itemCount: foodCubit.foodPlans.length,
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
