import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/blocs/signup/questionnaire_cubit/questionnaire_cubit.dart';
import 'package:gym/shared/enums.dart';
import 'package:gym/shared/extentions.dart';

import '../../../shared/constants.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../../../style/colors.dart';
import '../auth_widgets.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({
    super.key,
    this.isFromProfile = false,
    this.userId = '',
    this.token = '',
  });
  final bool isFromProfile;
  final String userId;
  final String token;

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionnaireCubit(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<QuestionnaireCubit, QuestionnaireState>(
            builder: (context, state) {
              QuestionnaireCubit questionnaireCubit =
                  context.read<QuestionnaireCubit>();
              return Stack(
                children: [
                  if (widget.isFromProfile)
                    DefaultAppBarWithRadius(
                      screenTitle: "editProfile".getLocale(context),
                      withBackArrow: true,
                    ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    margin: widget.isFromProfile
                        ? const EdgeInsets.only(top: 70.0)
                        : EdgeInsets.zero,
                    decoration: widget.isFromProfile
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          )
                        : const BoxDecoration(
                            color: Colors.white,
                          ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!widget.isFromProfile)
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                              left: 16,
                              bottom: 8,
                            ),
                            child: Text(
                              'personalHealth'.getLocale(context),
                              style: AppConstants.textTheme(context)
                                  .bodyLarge!
                                  .copyWith(
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 16)
                                .copyWith(bottom: 16, top: 8),
                            children: [
                              if (widget.isFromProfile)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4.0, top: 16),
                                  child: Text(
                                    'name'.getLocale(context),
                                    style: AppConstants.textTheme(context)
                                        .bodyLarge!
                                        .copyWith(
                                          color: AppColors.mainBlack,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                              if (widget.isFromProfile)
                                EmailTextField(
                                  marginTop: 8,
                                  marginBottom: 0,
                                  marginLeft: 0,
                                  marginRight: 0,
                                  textInputAction: TextInputAction.next,
                                  hint: AppConstants
                                          .authRepository.user.name.isNotEmpty
                                      ? AppConstants.authRepository.user.name
                                      : 'name'.getLocale(context),
                                  textInputType: TextInputType.name,
                                  onTap: () {},
                                  onSubmit: (value) {},
                                  onChange: (value) {},
                                  fieldValidation: TextFieldValidation.valid,
                                  controller: questionnaireCubit.nameCtrl,
                                ),
                              if (widget.isFromProfile)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4.0, top: 16),
                                  child: Text(
                                    'email'.getLocale(context),
                                    style: AppConstants.textTheme(context)
                                        .bodyLarge!
                                        .copyWith(
                                          color: AppColors.mainBlack,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                              if (widget.isFromProfile)
                                EmailTextField(
                                  marginTop: 8,
                                  marginBottom: 0,
                                  marginLeft: 0,
                                  marginRight: 0,
                                  textInputAction: TextInputAction.next,
                                  hint: AppConstants
                                          .authRepository.user.email.isNotEmpty
                                      ? AppConstants.authRepository.user.email
                                      : 'email'.getLocale(context),
                                  textInputType: TextInputType.emailAddress,
                                  onTap: () {},
                                  onSubmit: (value) {},
                                  onChange: (value) {},
                                  fieldValidation: TextFieldValidation.valid,
                                  controller: questionnaireCubit.emailCtrl,
                                ),
                              if (widget.isFromProfile)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4.0, top: 16),
                                  child: Text(
                                    'password'.getLocale(context),
                                    style: AppConstants.textTheme(context)
                                        .bodyLarge!
                                        .copyWith(
                                          color: AppColors.mainBlack,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                              if (widget.isFromProfile)
                                EmailTextField(
                                  marginTop: 8,
                                  marginBottom: 0,
                                  marginLeft: 0,
                                  marginRight: 0,
                                  textInputAction: TextInputAction.next,
                                  hint: 'password'.getLocale(context),
                                  textInputType: TextInputType.text,
                                  onTap: () {},
                                  onSubmit: (value) {},
                                  onChange: (value) {},
                                  fieldValidation: TextFieldValidation.valid,
                                  controller: questionnaireCubit.passwordCtrl,
                                ),
                              if (widget.isFromProfile)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4.0, top: 16),
                                  child: Text(
                                    'phone'.getLocale(context),
                                    style: AppConstants.textTheme(context)
                                        .bodyLarge!
                                        .copyWith(
                                          color: AppColors.mainBlack,
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                ),
                              if (widget.isFromProfile)
                                EmailTextField(
                                  marginTop: 8,
                                  marginBottom: 0,
                                  marginLeft: 0,
                                  marginRight: 0,
                                  textInputAction: TextInputAction.next,
                                  hint: AppConstants
                                          .authRepository.user.phone.isNotEmpty
                                      ? AppConstants.authRepository.user.phone
                                      : 'phone'.getLocale(context),
                                  textInputType: TextInputType.text,
                                  onTap: () {},
                                  onSubmit: (value) {},
                                  onChange: (value) {},
                                  fieldValidation: TextFieldValidation.valid,
                                  controller: questionnaireCubit.phoneCtrl,
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'yourAge'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: AppConstants.authRepository.user.age
                                        .toString()
                                        .isNotEmpty
                                    ? AppConstants.authRepository.user.age
                                        .toString()
                                    : 'yourAge'.getLocale(context),
                                textInputType:
                                    const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: true,
                                ),
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.ageCtrl,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'yourWeight'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: AppConstants.authRepository.user.weight
                                        .toString()
                                        .isNotEmpty
                                    ? AppConstants.authRepository.user.weight
                                        .toString()
                                    : 'yourWeight'.getLocale(context),
                                textInputType:
                                    const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: true,
                                ),
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.weight,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'yourHeight'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: AppConstants.authRepository.user.height
                                        .toString()
                                        .isNotEmpty
                                    ? AppConstants.authRepository.user.height
                                        .toString()
                                    : 'yourHeight'.getLocale(context),
                                textInputType:
                                    const TextInputType.numberWithOptions(
                                  signed: false,
                                  decimal: true,
                                ),
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.height,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'focusZone'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: AppConstants
                                        .authRepository.user.zone.isNotEmpty
                                    ? AppConstants.authRepository.user.zone
                                    : 'focusZone'.getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.zone,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'chronicDiseases'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: AppConstants.authRepository.user
                                        .chronicDiseases.isNotEmpty
                                    ? AppConstants
                                        .authRepository.user.chronicDiseases
                                    : 'chronicDiseases'.getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.chronicDiseases,
                              ),
                              // Nature of Your Job
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'natureOfYourJob'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: AppConstants
                                        .authRepository.user.job.isNotEmpty
                                    ? AppConstants.authRepository.user.job
                                    : 'natureOfYourJob'.getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.job,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'numOfWorkHours'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: AppConstants
                                        .authRepository.user.jobHours.isNotEmpty
                                    ? AppConstants.authRepository.user.jobHours
                                    : "numOfWorkHours".getLocale(context),
                                textInputType: TextInputType.datetime,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.jobHours,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'yourDailySchedule'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: AppConstants.authRepository.user
                                        .dailyActivity.isNotEmpty
                                    ? AppConstants
                                        .authRepository.user.dailyActivity
                                    : "yourDailySchedule".getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.yourDayPlan,
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'yourSleepTime'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.datetime,
                                hint: AppConstants.authRepository.user.sleepTime
                                        .isNotEmpty
                                    ? AppConstants.authRepository.user.sleepTime
                                    : "yourSleepTime".getLocale(context),
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.sleepTime,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'yourWakeUpTime'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.datetime,
                                hint: AppConstants.authRepository.user
                                        .wakeupTime.isNotEmpty
                                    ? AppConstants
                                        .authRepository.user.wakeupTime
                                    : "8 ${"AM".getLocale(context)}",
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.wakeUpTime,
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'haveYourTrainedBefore'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: "Yes/No".getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.isTrainedBefore,
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'howLongHaveYouTrained'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: "duration".getLocale(context),
                                textInputType: TextInputType.datetime,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.timeForTraining,
                              ),

                              // Type of Training
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'typeOfTraining'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: 'typeOfTraining'.getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.typeOfTraining,
                              ),

                              // Training Results
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'trainingResult'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: 'trainingResult'.getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.trainingResult,
                              ),

                              // Did You See Results?
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'didYouSeeResults'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: "Yes/No".getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.isTrainingResult,
                              ),

                              // Which Parts Improved?
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'whichPartsImproved'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: "Improved Parts",
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.trainingTarget,
                              ),

                              // Favorite Food
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'favoriteFood'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: 'favoriteFood'.getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.favFood,
                              ),

                              // Unfavorite Food
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'unFavoriteFood'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: 'unFavoriteFood'.getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.unFavFood,
                              ),

                              // Number of Meals per Day
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'numOfMealsPerDay'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: "4",
                                textInputType: TextInputType.number,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.numOfMeals,
                              ),

                              // Fast Food Consumption
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'fastFoodConsumption'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: 'fastFoodConsumption'.getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.fastFood,
                              ),

                              // Training Target
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'trainingTarget'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: 'trainingTarget'.getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit.trainingTarget,
                              ),

                              // Private or Online Training
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'privateOrOnlineTraining'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: "privateOrOnline".getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller:
                                    questionnaireCubit.privateOnlineOrOffline,
                              ),

                              // Do You Cook Your Own Food?
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'doYouCookYourOwnFood'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: "Yes/No".getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller:
                                    questionnaireCubit.isCookingYourFood,
                              ),

                              // Problems with Training and Diet
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4.0, top: 16),
                                child: Text(
                                  'problemsWithDiet'.getLocale(context),
                                  style: AppConstants.textTheme(context)
                                      .bodyLarge!
                                      .copyWith(
                                        color: AppColors.mainBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              EmailTextField(
                                marginTop: 8,
                                marginBottom: 0,
                                marginLeft: 0,
                                marginRight: 0,
                                textInputAction: TextInputAction.next,
                                hint: "problems".getLocale(context),
                                textInputType: TextInputType.text,
                                onTap: () {},
                                onSubmit: (value) {},
                                onChange: (value) {},
                                fieldValidation: TextFieldValidation.valid,
                                controller: questionnaireCubit
                                    .problemsWithTrainingAndDiet,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: state is SubmitAnswersLoadingState
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () {
                                      questionnaireCubit.submitAnswers(
                                        isFromProfile: widget.isFromProfile,
                                        context: context,
                                        userId: widget.isFromProfile
                                            ? AppConstants
                                                .authRepository.user.id
                                            : widget.userId,
                                        token: widget.token,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: AppColors.mainColor,
                                        textStyle:
                                            AppConstants.textTheme(context)
                                                .bodyMedium),
                                    child: Text(
                                      widget.isFromProfile
                                          ? "saveChanges".getLocale(context)
                                          : "submitAnswers".getLocale(context),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
