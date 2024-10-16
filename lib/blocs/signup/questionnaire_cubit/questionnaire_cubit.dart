import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/presentation/main_screens/default_success_screen.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/shared/extentions.dart';
import 'package:gym/shared/navigate_functions.dart';

import '../../../services/dio_helper.dart';
import '../../../shared/widgets/snackbar.dart';

part 'questionnaire_state.dart';

class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  QuestionnaireCubit() : super(QuestionnaireInitial());

  TextEditingController ageCtrl = TextEditingController(),
      zone = TextEditingController(),
      height = TextEditingController(),
      weight = TextEditingController(),
      job = TextEditingController(),
      jobHours = TextEditingController(),
      yourDayPlan = TextEditingController(),
      sleepTime = TextEditingController(),
      wakeUpTime = TextEditingController(),
      isTrainedBefore = TextEditingController(),
      timeForTraining = TextEditingController(),
      typeOfTraining = TextEditingController(),
      trainingResult = TextEditingController(),
      isTrainingResult = TextEditingController(),
      favFood = TextEditingController(),
      unFavFood = TextEditingController(),
      numOfMeals = TextEditingController(),
      fastFood = TextEditingController(),
      trainingTarget = TextEditingController(),
      privateOnlineOrOffline = TextEditingController(),
      isCookingYourFood = TextEditingController(),
      nameCtrl = TextEditingController(),
      emailCtrl = TextEditingController(),
      passwordCtrl = TextEditingController(),
      phoneCtrl = TextEditingController(),
      chronicDiseases = TextEditingController(),
      problemsWithTrainingAndDiet = TextEditingController();

  Future<void> submitAnswers({
    required BuildContext context,
    required String userId,
    String token = '',
    bool isFromProfile = false,
  }) async {
    emit(SubmitAnswersLoadingState());
    try {
      Response response = await DioHelper.postData(
        userToken: token.isNotEmpty ? token : null,
        endpoint:
            "auth/questionnaires/${isFromProfile ? AppConstants.authRepository.user.id : userId}/update",
        body: {
          if (nameCtrl.text.isNotEmpty) "name": nameCtrl.text,
          if (emailCtrl.text.isNotEmpty) "email": emailCtrl.text,
          if (passwordCtrl.text.isNotEmpty) "password": passwordCtrl.text,
          if (phoneCtrl.text.isNotEmpty) "phone": phoneCtrl.text,
          if (zone.text.isNotEmpty) "zone": zone.text,
          if (height.text.isNotEmpty)
            "height": double.tryParse(height.text) ?? 0,
          if (weight.text.isNotEmpty)
            "weight": double.tryParse(weight.text) ?? 0,
          if (ageCtrl.text.isNotEmpty)
            "age": double.tryParse(ageCtrl.text) ?? 0,
          if (job.text.isNotEmpty) "job": job.text,
          if (jobHours.text.isNotEmpty) "job_hours": jobHours.text,
          if (yourDayPlan.text.isNotEmpty) "daily_activity": yourDayPlan.text,
          if (sleepTime.text.isNotEmpty) "sleep_time": sleepTime.text,
          if (wakeUpTime.text.isNotEmpty) "wakeup_time": wakeUpTime.text,
          if (isTrainedBefore.text.isNotEmpty)
            "trained_before":
                isTrainedBefore.text.toLowerCase() == "yes" ? 1 : 0,
          if (timeForTraining.text.isNotEmpty)
            "How_much_did_you_exercise": timeForTraining.text,
          if (typeOfTraining.text.isNotEmpty)
            "exercises_type": typeOfTraining.text,
          if (isTrainingResult.text.isNotEmpty)
            "see_results": isTrainingResult.text.toLowerCase() == "yes" ? 1 : 0,
          if (trainingResult.text.isNotEmpty) "feedback": trainingResult.text,
          if (favFood.text.isNotEmpty) "fav_food": favFood.text,
          if (unFavFood.text.isNotEmpty) "unfav_food": unFavFood.text,
          if (numOfMeals.text.isNotEmpty) "eating_times": numOfMeals.text,
          if (fastFood.text.isNotEmpty) "home_street": fastFood.text,
          if (trainingTarget.text.isNotEmpty) "traget": trainingTarget.text,
          if (chronicDiseases.text.isNotEmpty)
            "chronic_diseases": chronicDiseases.text,
          if (privateOnlineOrOffline.text.isNotEmpty)
            "offline_online": privateOnlineOrOffline.text,
          if (isCookingYourFood.text.isNotEmpty)
            "made_food": isCookingYourFood.text,
          if (problemsWithTrainingAndDiet.text.isNotEmpty)
            "diet_issues": problemsWithTrainingAndDiet.text,
        },
      );
      if (response.statusCode == 200) {
        if (context.mounted) {
          defaultSuccessSnackBar(
            context: context,
            message: "answerSent".getLocale(context),
          );
        }
        if (isFromProfile) {
          if (nameCtrl.text.isNotEmpty) {
            AppConstants.authRepository.user.name = nameCtrl.text;
          }
          if (emailCtrl.text.isNotEmpty) {
            AppConstants.authRepository.user.email = emailCtrl.text;
          }
          if (phoneCtrl.text.isNotEmpty) {
            AppConstants.authRepository.user.phone = phoneCtrl.text;
          }
          if (zone.text.isNotEmpty) {
            AppConstants.authRepository.user.zone = zone.text;
          }
          if (height.text.isNotEmpty) {
            AppConstants.authRepository.user.height =
                int.tryParse(height.text) ??
                    AppConstants.authRepository.user.height;
          }
          if (weight.text.isNotEmpty) {
            AppConstants.authRepository.user.weight =
                int.tryParse(weight.text) ??
                    AppConstants.authRepository.user.weight;
          }
          if (ageCtrl.text.isNotEmpty) {
            AppConstants.authRepository.user.age = int.tryParse(ageCtrl.text) ??
                AppConstants.authRepository.user.age;
          }
          if (job.text.isNotEmpty) {
            AppConstants.authRepository.user.job = job.text;
          }
          if (jobHours.text.isNotEmpty) {
            AppConstants.authRepository.user.jobHours = jobHours.text;
          }
          if (yourDayPlan.text.isNotEmpty) {
            AppConstants.authRepository.user.dailyActivity = yourDayPlan.text;
          }
          if (sleepTime.text.isNotEmpty) {
            AppConstants.authRepository.user.sleepTime = sleepTime.text;
          }
          if (wakeUpTime.text.isNotEmpty) {
            AppConstants.authRepository.user.wakeupTime = wakeUpTime.text;
          }
          if (isTrainedBefore.text.isNotEmpty) {
            AppConstants.authRepository.user.trainedBefore =
                isTrainedBefore.text.toLowerCase() == "yes" ? true : false;
          }
          if (typeOfTraining.text.isNotEmpty) {
            AppConstants.authRepository.user.exercisesType =
                typeOfTraining.text;
          }
          if (timeForTraining.text.isNotEmpty) {
            AppConstants.authRepository.user.howMuchDidYouExercise =
                timeForTraining.text;
          }
          if (isTrainingResult.text.isNotEmpty) {
            AppConstants.authRepository.user.seeResults =
                isTrainingResult.text.toLowerCase() == "yes" ? true : false;
          }
          if (trainingResult.text.isNotEmpty) {
            AppConstants.authRepository.user.feedback = trainingResult.text;
          }
          if (favFood.text.isNotEmpty) {
            AppConstants.authRepository.user.favFood = favFood.text;
          }
          if (unFavFood.text.isNotEmpty) {
            AppConstants.authRepository.user.unfavFood = unFavFood.text;
          }
          if (numOfMeals.text.isNotEmpty) {
            AppConstants.authRepository.user.eatingTimes = numOfMeals.text;
          }
          if (fastFood.text.isNotEmpty) {
            AppConstants.authRepository.user.homeStreet = fastFood.text;
          }
          if (trainingTarget.text.isNotEmpty) {
            AppConstants.authRepository.user.target = trainingTarget.text;
          }
          if (chronicDiseases.text.isNotEmpty) {
            AppConstants.authRepository.user.chronicDiseases =
                chronicDiseases.text;
          }
          if (privateOnlineOrOffline.text.isNotEmpty) {
            AppConstants.authRepository.user.offlineOnline =
                privateOnlineOrOffline.text;
          }
          if (isCookingYourFood.text.isNotEmpty) {
            AppConstants.authRepository.user.madeFood = isCookingYourFood.text;
          }
          if (problemsWithTrainingAndDiet.text.isNotEmpty) {
            AppConstants.authRepository.user.dietIssues =
                problemsWithTrainingAndDiet.text;
          }
          AppConstants.authRepository.getUser();
        } else {
          await Future.delayed(const Duration(seconds: 1));
          if (context.mounted) {
            Navigate(
              screen: const DefaultSuccessScreen(),
              context: context,
            ).to();
          }
        }
        emit(SubmitAnswersSuccessState());
      } else {
        if (context.mounted) {
          defaultErrorSnackBar(
            context: context,
            message: response.data['error'],
          );
        }
        emit(SubmitAnswersErrorState(response.data['error']));
      }
    } catch (e) {
      if (context.mounted) {
        defaultErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
      emit(SubmitAnswersErrorState(e.toString()));
    }
  }
}
