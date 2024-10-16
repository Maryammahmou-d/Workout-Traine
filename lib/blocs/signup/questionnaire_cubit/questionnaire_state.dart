part of 'questionnaire_cubit.dart';

@immutable
abstract class QuestionnaireState {}

class QuestionnaireInitial extends QuestionnaireState {}
class SubmitAnswersLoadingState extends QuestionnaireState {}
class SubmitAnswersSuccessState extends QuestionnaireState {}
class SubmitAnswersErrorState extends QuestionnaireState {
  final String errMsg;

  SubmitAnswersErrorState(this.errMsg);
}
