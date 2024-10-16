import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/home/home_cubit.dart';
import 'package:gym/presentation/main_screens/home/chat_screen.dart';
import 'package:gym/presentation/main_screens/home/reminder_screen.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/shared/extentions.dart';

import '../../../blocs/layout/layout_cubit.dart';
import '../../../dummy_data.dart';
import '../../../shared/navigate_functions.dart';
import '../../../style/colors.dart';
import '../settings/profile_screen.dart';
import 'home_widgets/home_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: AppConstants.screenSize(context).width - 40,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${"hi".getLocale(context)}! ${AppConstants.authRepository.user.name}",
                    style: AppConstants.textTheme(context).titleLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          wordSpacing: 0,
                        ),
                  ),
                  const Spacer(),
                  CircularContainerWithIcons(onTap: () {
                    Navigate(
                      context: context,
                      screen: BlocProvider.value(
                        value: context.read<HomeCubit>(),
                        child: const ReminderScreen(),
                      ),
                    ).to();
                  }),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () async {
                      Navigate(
                        context: context,
                        screen: ProfileScreen(
                          homeCubit: context.read<HomeCubit>(),
                        ),
                      ).to();
                    },
                    child: BlocBuilder<HomeCubit, HomeState>(
                      buildWhen: (previous, current) =>
                          current is UpdateProfilePicture,
                      builder: (context, state) {
                        return CircleAvatar(
                          backgroundColor: AppColors.white,
                          radius: 20,
                          foregroundImage: AppConstants.authRepository.user
                                  .profilePhotoPath.isNotEmpty
                              ? context.watch<HomeCubit>().profilePicture !=
                                      null
                                  ? FileImage(
                                      context.read<HomeCubit>().profilePicture!)
                                  : NetworkImage(
                                      AppConstants
                                          .authRepository.user.profilePhotoPath,
                                    ) as ImageProvider<Object>
                              : const AssetImage(
                                  "assets/avatar_placeholder.jpg"),
                          backgroundImage: NetworkImage(
                            AppConstants.authRepository.user.profilePhotoUrl,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: const PageScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: Text(
                      "yourPersonal".getLocale(context),
                      style:
                          AppConstants.textTheme(context).titleMedium!.copyWith(
                                fontWeight: FontWeight.w700,
                                wordSpacing: 0,
                              ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 8),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: homeScreenGrid.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (index == 0) {
                            context
                                .read<LayoutCubit>()
                                .changeNavBarSelectedIndex(1);
                          } else if (index == 4) {
                            context
                                .read<LayoutCubit>()
                                .changeNavBarSelectedIndex(2);
                          } else if (index == 5) {
                            context
                                .read<LayoutCubit>()
                                .changeNavBarSelectedIndex(3);
                          } else {
                            Navigate(
                              context: context,
                              screen: homeScreenGrid[index]['screen'],
                            ).to();
                          }
                        },
                        child: Container(
                          width:
                              (AppConstants.screenSize(context).width - 52) / 2,
                          height: 100.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Shadow color
                                spreadRadius: 2, // How spread out the shadow is
                                blurRadius: 5, // How blurry the shadow is
                                offset: const Offset(0, 3),
                              ),
                            ],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                homeScreenGrid[index]['imageUrl'],
                              ),
                            ),
                            // border: Border.all(
                            //   color: AppColors.lightGrey.withOpacity(0.1),
                            //   width: 0.4,
                            // ),
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.mainColor,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black.withOpacity(0.75),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    homeScreenGrid[index]['title']
                                        .toString()
                                        .getLocale(context),
                                    textAlign: TextAlign.center,
                                    style: AppConstants.textTheme(context)
                                        .bodyLarge!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {},
                  //   child: Container(
                  //     margin: const EdgeInsets.only(bottom: 20),
                  //     width: AppConstants.screenSize(context).width - 40,
                  //     height: 100.0,
                  //     decoration: BoxDecoration(
                  //       image: const DecorationImage(
                  //         fit: BoxFit.cover,
                  //         image: AssetImage(
                  //           'assets/images/home/credit_card.jpg',
                  //         ),
                  //       ),
                  //       borderRadius: BorderRadius.circular(12),
                  //       color: AppColors.mainColor,
                  //     ),
                  //     child: Stack(
                  //       children: [
                  //         Container(
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(12),
                  //             color: Colors.black.withOpacity(0.75),
                  //           ),
                  //         ),
                  //         Center(
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(16),
                  //             child: Text(
                  //               'Subscription',
                  //               textAlign: TextAlign.center,
                  //               style: AppConstants.textTheme(context)
                  //                   .bodyLarge!
                  //                   .copyWith(
                  //                     color: Colors.white,
                  //                     fontWeight: FontWeight.w700,
                  //                   ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        foregroundColor: AppColors.lightGrey,
        onPressed: () {
          Navigate(
            context: context,
            screen: ChatScreen(
              homeCubit: context.read<HomeCubit>(),
            ),
          ).to();
        },

        child: const Icon(
          Icons.chat,
        ), // You can change the icon as needed
      ),
    );
  }
}
