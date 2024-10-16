import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/home/home_cubit.dart';
import 'package:gym/blocs/profile/profile_cubit.dart';
import 'package:gym/blocs/profile/profile_state.dart';
import 'package:gym/presentation/authentications/signup/questionnaire_screen.dart';
import 'package:gym/presentation/main_screens/settings/settings_widgets.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/shared/extentions.dart';
import 'package:gym/shared/navigate_functions.dart';
import 'package:intl/intl.dart';

import '../../../models/user_model.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../../../style/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    this.homeCubit,
  });

  final HomeCubit? homeCubit;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel userModel = AppConstants.authRepository.user;

  @override
  void initState() {
    setState(() {
      userModel = AppConstants.authRepository.user;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      userModel = AppConstants.authRepository.user;
    });
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      body: SafeArea(
        child: DefaultContainerWithAppBar(
          screenTitle: "myProfile".getLocale(context),
          headerIcon: IconButton(
            icon: const Icon(
              Icons.edit_note_outlined,
            ),
            onPressed: () {
              Navigate(
                  context: context,
                  screen: const QuestionnaireScreen(
                    isFromProfile: true,
                  )).to().then((value) {
                setState(() {});
              });
            },
          ),
          children: const [],
          child: BlocProvider(
            create: (context) => ProfileCubit(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (widget.homeCubit != null) {
                        if (AppConstants.profilePicture != null) {
                          widget.homeCubit!.updateProfilePicture(
                              AppConstants.profilePicture!);
                        }
                      }
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            bottom: 12,
                          ),
                          child: state is UploadProfilePictureLoadingState ||
                                  state is GetProfileLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : userModel.profilePhotoPath.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        context
                                            .read<ProfileCubit>()
                                            .pickImageFromGallery(context);
                                      },
                                      child: CircleAvatar(
                                        backgroundImage: AppConstants
                                                    .profilePicture !=
                                                null
                                            ? FileImage(
                                                AppConstants.profilePicture!)
                                            : NetworkImage(
                                                userModel.profilePhotoPath,
                                              ) as ImageProvider<Object>,
                                        radius: 40,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        context
                                            .read<ProfileCubit>()
                                            .pickImageFromGallery(context);
                                      },
                                      child: const CircleAvatar(
                                        radius: 35,
                                        foregroundImage: AssetImage(
                                          "assets/avatar_placeholder.jpg",
                                        ),
                                      ),
                                    ),
                        ),
                      );
                    },
                  ),
                  Text(
                    userModel.name,
                    style: AppConstants.textTheme(context).titleSmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                          wordSpacing: 0,
                        ),
                  ),
                  Text(
                    userModel.email,
                    style: AppConstants.textTheme(context).bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.regularGrey,
                          wordSpacing: 0,
                        ),
                  ),
                  Container(
                    width: AppConstants.screenSize(context).width - 40,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08), // Shadow color
                          blurRadius: 8.0, // Blur radius
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProfileRow(
                          title: "name".getLocale(context),
                          value: userModel.name,
                          onTap: () {},
                        ),
                        const Divider(
                          height: 0,
                          color: AppColors.lightGrey,
                          thickness: 1,
                        ),
                        ProfileRow(
                          title: "age".getLocale(context),
                          value: userModel.age.toString(),
                          onTap: () {},
                        ),
                        const Divider(
                          height: 0,
                          color: AppColors.lightGrey,
                          thickness: 1,
                        ),
                        ProfileRow(
                          title: "height".getLocale(context),
                          value:
                              "${userModel.height} ${"cm".getLocale(context)}",
                          onTap: () {},
                        ),
                        const Divider(
                          height: 0,
                          color: AppColors.lightGrey,
                          thickness: 1,
                        ),
                        ProfileRow(
                          title: "weight".getLocale(context),
                          value:
                              "${userModel.weight} ${"kg".getLocale(context)}",
                          onTap: () {},
                        ),
                        const Divider(
                          height: 0,
                          color: AppColors.lightGrey,
                          thickness: 1,
                        ),
                        ProfileRow(
                          title: "focusZone".getLocale(context),
                          value: userModel.zone,
                          onTap: () {},
                        ),
                        const Divider(
                          height: 0,
                          color: AppColors.lightGrey,
                          thickness: 1,
                        ),
                        ProfileRow(
                          title: "goal".getLocale(context),
                          value: userModel.target,
                          onTap: () {},
                        ),
                        // const Divider(
                        //   height: 0,
                        //   color: AppColors.lightGrey,
                        //   thickness: 1,
                        // ),
                        // ProfileRow(
                        //   title: "chronicDiseases".getLocale(context),
                        //   value: userModel.chronicDise,
                        //   onTap: () {},
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    width: AppConstants.screenSize(context).width - 40,
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 30,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08), // Shadow color
                          blurRadius: 8.0, // Blur radius
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ProfileRow(
                          title: "subscriptionStartDate".getLocale(context),
                          value: DateFormat('dd-MM-yyyy')
                              .format(userModel.enrollmentStartDate)
                              .toString(),
                          onTap: () {},
                        ),
                        const Divider(
                          height: 0,
                          color: AppColors.lightGrey,
                          thickness: 1,
                        ),
                        ProfileRow(
                          isWithArrow: false,
                          title: "subscriptionEndDate".getLocale(context),
                          value: DateFormat('dd-MM-yyyy')
                              .format(userModel.enrollmentExpireDate)
                              .toString(),
                          onTap: () {},
                        ),
                        const Divider(
                          height: 0,
                          color: AppColors.lightGrey,
                          thickness: 1,
                        ),
                        ProfileRow(
                          isWithArrow: false,
                          title: "inBodyCheckUp".getLocale(context),
                          value: userModel.checkInEveryDate,
                          onTap: () {},
                        ),
                        const Divider(
                          height: 0,
                          color: AppColors.lightGrey,
                          thickness: 1,
                        ),
                        ProfileRow(
                          isWithArrow: false,
                          title: "followUpDate".getLocale(context),
                          value: userModel.followUpDate,
                          onTap: () {},
                        ),
                      ],
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
