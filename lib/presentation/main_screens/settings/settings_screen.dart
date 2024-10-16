import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/localization/cubit/localization_cubit.dart';
import 'package:gym/blocs/profile/profile_state.dart';
import 'package:gym/presentation/authentications/login/login_screen.dart';
import 'package:gym/presentation/main_screens/settings/profile_screen.dart';
import 'package:gym/presentation/main_screens/settings/settings_widgets.dart';
import 'package:gym/services/local_storage/cache_helper.dart';
import 'package:gym/shared/extentions.dart';
import 'package:gym/shared/widgets/shared_widgets.dart';
import 'package:gym/shared/widgets/snackbar.dart';

import '../../../blocs/profile/profile_cubit.dart';
import '../../../models/user_model.dart';
import '../../../shared/constants.dart';
import '../../../shared/navigate_functions.dart';
import '../../../style/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: DefaultContainerWithAppBar(
          screenTitle: "settings".getLocale(context),
          children: const [],
          containerColor: AppColors.lightGrey,
          child: SingleChildScrollView(
            child: SizedBox(
              width: AppConstants.screenSize(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultWhiteContainer(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProfileRow(
                          isWithArrow: true,
                          icon: Icons.person_2_outlined,
                          title: "userProfile".getLocale(context),
                          value: '',
                          onTap: () {
                            Navigate(
                              context: context,
                              screen: const ProfileScreen(),
                            ).to();
                          },
                        ),
                        const DefaultDivider(),
                        ProfileRow(
                          icon: Icons.language_outlined,
                          title: "Language".getLocale(context),
                          value: '',
                          isWithArrow: false,
                          onTap: () {},
                          suffixWidget: DropdownButton<String>(
                            underline: const SizedBox(),
                            dropdownColor: Colors.white,
                            iconEnabledColor: Colors.black,
                            value: context
                                    .read<LocalizationCubit>()
                                    .state
                                    .locale
                                    .toString()
                                    .contains('en')
                                ? 'English'
                                : 'Arabic',
                            onChanged: (String? newValue) {
                              if (newValue == "English") {
                                context.read<LocalizationCubit>().toEnglish();
                              } else {
                                context.read<LocalizationCubit>().toArabic();
                              }
                            },
                            items: <String>['English', 'Arabic']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        wordSpacing: 0,
                                        color: AppColors.black,
                                      ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const DefaultDivider(),
                        ProfileRow(
                          textColor: AppColors.red,
                          isWithArrow: false,
                          icon: Icons.logout_rounded,
                          title: "Logout".getLocale(context),
                          value: '',
                          onTap: () {
                            AppConstants.authRepository.user =
                                UserModel.emptyUser();
                            CacheHelper.clearAll();
                            Navigate(
                              context: context,
                              screen: const LoginScreen(),
                            ).offAll();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: AppConstants.screenSize(context).width,
                    child: TextButton(
                      onPressed: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (context) {
                            return BlocProvider(
                              create: (context) => ProfileCubit(),
                              child: Material(
                                color: Colors.transparent,
                                child: Center(
                                  child: Container(
                                    width:
                                        AppConstants.screenSize(context).width,
                                    height: 210,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "areUSureUWantToDelete"
                                              .getLocale(context),
                                          textAlign: TextAlign.center,
                                          style: AppConstants.textTheme(context)
                                              .titleSmall!
                                              .copyWith(
                                                color: AppColors.mainColor,
                                                height: 1.2,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16.0),
                                          child: Text(
                                            "byPerformingThisActionOfDeleting"
                                                .getLocale(context),
                                            textAlign: TextAlign.center,
                                            style:
                                                AppConstants.textTheme(context)
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: AppColors.mainColor
                                                          .withOpacity(0.5),
                                                      height: 1.3,
                                                    ),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DefaultButton(
                                              width: (AppConstants.screenSize(
                                                              context)
                                                          .width -
                                                      80) /
                                                  2,
                                              function: () {
                                                Navigator.pop(context);
                                              },
                                              text: "cancel".getLocale(context),
                                              color: AppColors.mainColor
                                                  .withOpacity(0.2),
                                              borderRadius: 12,
                                              marginBottom: 0,
                                              marginLeft: 0,
                                              marginRight: 0,
                                              marginTop: 0,
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            BlocConsumer<ProfileCubit,
                                                ProfileState>(
                                              listener: (context, state) {
                                                if (state
                                                    is DeleteUserAccountErrorState) {
                                                  defaultErrorSnackBar(
                                                    context: context,
                                                    message: state.errMsg,
                                                  );
                                                } else if (state
                                                    is DeleteUserAccountSuccessState) {
                                                  Navigate(
                                                    context: context,
                                                    screen: const LoginScreen(),
                                                  ).offAll();
                                                }
                                              },
                                              listenWhen: (previous, current) =>
                                                  current is DeleteUserAccountLoadingState ||
                                                  current
                                                      is DeleteUserAccountSuccessState ||
                                                  current
                                                      is DeleteUserAccountErrorState,
                                              buildWhen: (previous, current) =>
                                                  current is DeleteUserAccountLoadingState ||
                                                  current
                                                      is DeleteUserAccountSuccessState ||
                                                  current
                                                      is DeleteUserAccountErrorState,
                                              builder: (context, state) {
                                                return DefaultButton(
                                                  loading: state
                                                      is DeleteUserAccountLoadingState,
                                                  width:
                                                      (AppConstants.screenSize(
                                                                      context)
                                                                  .width -
                                                              80) /
                                                          2,
                                                  function: () async {
                                                    context
                                                        .read<ProfileCubit>()
                                                        .deleteUser();
                                                  },
                                                  text: "delete"
                                                      .getLocale(context),
                                                  color: AppColors.red,
                                                  borderRadius: 12,
                                                  marginBottom: 0,
                                                  marginLeft: 0,
                                                  marginRight: 0,
                                                  marginTop: 0,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.delete_outline_rounded,
                            color: AppColors.red,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "deleteYourAccount".getLocale(context),
                            style: AppConstants.textTheme(context)
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  wordSpacing: 0,
                                  color: AppColors.red,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
