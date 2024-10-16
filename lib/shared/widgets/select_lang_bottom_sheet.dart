import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym/blocs/localization/cubit/localization_cubit.dart';
import 'package:gym/shared/extentions.dart';

import '../../style/colors.dart';
import '../constants.dart';

class SelectLangBottomSheet extends StatelessWidget {
  const SelectLangBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            barrierColor: null,
            backgroundColor: AppColors.black.withOpacity(0.6),
            builder: (context) => Container(
                  // height: height,
                  // width: width,
                  // padding: padding,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                  // context: context,
                  child: BlocBuilder<LocalizationCubit, LocalizationState>(
                    builder: (context, state) {
                      final LocalizationCubit localizationCubit =
                          context.read<LocalizationCubit>();
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: AppConstants.screenSize(context).width,
                            height: 85,
                            padding: AppConstants.edge(
                              top: 8,
                              bottom: 24,
                            ),
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 58,
                                  height: 6,
                                  decoration: ShapeDecoration(
                                    color: AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                Text(
                                  "selectLang".getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 18,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: AppConstants.screenSize(context).width,
                            padding: AppConstants.edge(
                              top: 24,
                              bottom: 24,
                              left: 16,
                              right: 16,
                            ),
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              color: AppColors.white,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'assets/images/england.svg',
                                      width: 24,
                                      height: 24,
                                      fit: BoxFit.fill,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'english'.getLocale(context),
                                      style: AppConstants.textTheme(context)
                                          .bodyLarge!
                                          .copyWith(
                                            fontSize: 18,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const Spacer(),
                                    Transform.scale(
                                      scale: 1.3,
                                      child: Radio<String>(
                                        value: 'en_US',
                                        fillColor:
                                            WidgetStateColor.resolveWith(
                                                (states) =>
                                                    AppColors.mainColor),
                                        groupValue: localizationCubit
                                            .state.locale.languageCode,
                                        onChanged: (value) {
                                          context
                                              .read<LocalizationCubit>()
                                              .toEnglish();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'assets/images/saudi_arabia.svg',
                                      width: 24,
                                      height: 24,
                                      fit: BoxFit.fill,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'arabic'.getLocale(context),
                                      style: AppConstants.textTheme(context)
                                          .bodyLarge!
                                          .copyWith(
                                            fontSize: 18,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    const Spacer(),
                                    Transform.scale(
                                      scale: 1.3,
                                      child: Radio<String>(
                                        value: 'ar_SA',
                                        fillColor:
                                            WidgetStateColor.resolveWith(
                                          (states) => AppColors.mainColor,
                                        ),
                                        groupValue: localizationCubit
                                            .state.locale.languageCode,
                                        onChanged: (value) {
                                          context
                                              .read<LocalizationCubit>()
                                              .toArabic();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ));
      },
      child: SvgPicture.asset(
        'assets/images/global.svg',
        color: AppColors.black.withOpacity(0.6),
        width: 24,
        height: 24,
      ),
    );
  }
}
