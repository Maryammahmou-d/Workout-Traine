import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/shared/extentions.dart';
import 'package:gym/shared/widgets/shared_widgets.dart';

import '../../blocs/localization/cubit/localization_cubit.dart';
import '../../style/colors.dart';
import 'onboarding_screen.dart';

class FirstSelectLangScreen extends StatelessWidget {
  const FirstSelectLangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: SizedBox(
          height: AppConstants.screenSize(context).height,
          width: AppConstants.screenSize(context).width,
          child: Stack(
            children: [
              Image.asset(
                "assets/images/yousef/1.jpeg",
                fit: BoxFit.cover,
                height: AppConstants.screenSize(context).height,
                width: AppConstants.screenSize(context).width,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "selectYourLang".getLocale(context),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LangContainer(
                        isSelected: context
                            .watch<LocalizationCubit>()
                            .state
                            .locale
                            .toString()
                            .contains('en'),
                        imgPath: "assets/images/us-circle-flag.png",
                        lang: "English".getLocale(context),
                        onTap: () {
                          context.read<LocalizationCubit>().toEnglish();
                        },
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      LangContainer(
                        isSelected: context
                            .watch<LocalizationCubit>()
                            .state
                            .locale
                            .toString()
                            .contains('ar'),
                        imgPath: "assets/images/eg-flag.png",
                        lang: "Arabic".getLocale(context),
                        onTap: () {
                          context.read<LocalizationCubit>().toArabic();
                        },
                      ),
                    ],
                  ),
                  DefaultButton(
                    marginTop: 24,
                    marginLeft: 20,
                    marginRight: 20,
                    width: 140,
                    function: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const OnboardingScreen(),
                        ),
                      );
                    },
                    text: "done".getLocale(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LangContainer extends StatelessWidget {
  const LangContainer({
    super.key,
    required this.isSelected,
    required this.imgPath,
    required this.lang,
    required this.onTap,
  });

  final bool isSelected;
  final String imgPath;
  final String lang;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: (AppConstants.screenSize(context).width - 60) / 2,
        width: (AppConstants.screenSize(context).width - 60) / 2,
        decoration: BoxDecoration(
          color: AppColors.lightColor,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(
                  color: AppColors.oldMainColor,
                  width: 2,
                )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imgPath,
              height: (AppConstants.screenSize(context).width - 60) / 4,
              width: (AppConstants.screenSize(context).width - 60) / 4,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              lang,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
