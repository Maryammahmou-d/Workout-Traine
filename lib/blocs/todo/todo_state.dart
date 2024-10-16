part of 'todo_cubit.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class LoadTodoListState extends TodoState {
  @override
  List<Object> get props => [];
}

class ChangeSelectedDayState extends TodoState {
  final DateTime date;

  const ChangeSelectedDayState(this.date);

  @override
  List<Object?> get props => [date];
}

class ChangeCurrentListState extends TodoState {
  final DateTime date;
  final List<Todo> todo;

  const ChangeCurrentListState(this.date, this.todo);

  @override
  List<Object?> get props => [date, todo];
}

class LoadTodoState extends TodoState {
  final List<Todo> todo;

  const LoadTodoState(this.todo);

  @override
  List<Object?> get props => [todo];
}

class SaveTodoState extends TodoState {
  final List<Todo> todo;

  const SaveTodoState(this.todo);

  @override
  List<Object?> get props => [todo];
}

class ToggleTodoState extends TodoState {
  final String todo;
  final String apiKey;
  final bool isDone;

  const ToggleTodoState(
    this.todo,
    this.apiKey,
    this.isDone,
  );

  @override
  List<Object?> get props => [
        todo,
        apiKey,
        isDone,
      ];
}

class RemoveTodoState extends TodoState {
  final List<Todo> todo;

  const RemoveTodoState(this.todo);

  @override
  List<Object?> get props => [todo];
}

class UpdateTodoProgressState extends TodoState {
  final Todo todo;
  final double progress;
  final bool isSubTaskDone;
  final int subTaskIndex;

  const UpdateTodoProgressState(
    this.todo,
    this.progress,
    this.isSubTaskDone,
    this.subTaskIndex,
  );

  @override
  List<Object?> get props => [todo, progress, isSubTaskDone, subTaskIndex];
}

class UpdateEditableTodoProgressState extends TodoState {
  final Todo todo;
  final String progress;

  const UpdateEditableTodoProgressState(this.todo, this.progress);

  @override
  List<Object?> get props => [todo, progress];
}

class AddTodoTargetState extends TodoState {
  final Todo todo;
  final double target;

  const AddTodoTargetState(this.todo, this.target);

  @override
  List<Object?> get props => [todo, target];
}

class SendTodoToApisLoadingState extends TodoState {
  @override
  List<Object> get props => [];
}

class SendTodoToApisSuccessState extends TodoState {
  @override
  List<Object> get props => [];
}

class SendTodoToApisErrorState extends TodoState {
  final String errMsg;

  const SendTodoToApisErrorState(this.errMsg);
  @override
  List<Object> get props => [errMsg];
}
