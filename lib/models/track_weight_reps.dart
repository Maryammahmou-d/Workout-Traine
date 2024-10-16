import 'package:gym/models/workout_details_model.dart';

class TrackingModel {
  final String workoutDay;
  final List<Workout> workouts;

  TrackingModel(this.workoutDay, this.workouts);
}

class LbsAndRepsModel {
  int lbs;
  int reps;
  bool isDone;

  LbsAndRepsModel(
    this.lbs,
    this.reps, {
    this.isDone = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'lbs': lbs,
      'reps': reps,
      // 'isDone': isDone,
    };
  }

  factory LbsAndRepsModel.fromJson(Map<String, dynamic> json) {
    return LbsAndRepsModel(
      json['lbs'] ?? 0,
      json['reps'] ?? 0,
      isDone: json['isDone'] ?? false,
    );
  }
}
