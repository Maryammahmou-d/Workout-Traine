import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/shared/extentions.dart';

import '../../../blocs/layout/layout_cubit.dart';
import '../../../style/colors.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.darkHeader,
      child: SafeArea(
        top: false,
        child: Container(
          height: 70,
          color: AppColors.darkHeader,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Divider(
                color: AppColors.mainBlack,
                thickness: 1,
                height: 0,
              ),
              const SizedBox(
                height: 6,
              ),
              BlocBuilder<LayoutCubit, LayoutState>(
                buildWhen: (previous, current) =>
                    current is ChangeNavBarValueState,
                builder: (context, state) {
                  return BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: AppColors.darkHeader,
                    elevation: 0,
                    onTap:
                        context.read<LayoutCubit>().changeNavBarSelectedIndex,
                    currentIndex: context.read<LayoutCubit>().navbarIndex,
                    showUnselectedLabels: true,
                    showSelectedLabels: true,
                    iconSize: 28,
                    selectedLabelStyle:
                        Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                    unselectedLabelStyle:
                        Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                    selectedItemColor: AppColors.oldMainColor,
                    unselectedItemColor: AppColors.white,
                    items: [
                      BottomNavigationBarItem(
                        icon: const Icon(
                          Icons.home_outlined,
                          size: 28,
                        ),
                        label: "home".getLocale(context),
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          "assets/gloves.png",
                          height: 28,
                          width: 28,
                          color: context.read<LayoutCubit>().navbarIndex == 1
                              ? AppColors.oldMainColor
                              : AppColors.white,
                        ),
                        label: "workouts".getLocale(context),
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(
                          Icons.note_alt_outlined,
                        ),
                        label: "todo".getLocale(context),
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(
                          Icons.trending_up,
                        ),
                        label: "trackWeight".getLocale(context),
                      ),
                    ],
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
