class WorkoutsPlanModel {
  String planName;
  Map<String, List<ExerciseModel>> exercisesForDays;

  WorkoutsPlanModel({
    required this.planName,
    required this.exercisesForDays,
  });

  factory WorkoutsPlanModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> exercisesForDaysJson = json['exercises_for_days'];
    Map<String, List<ExerciseModel>> exercisesForDays = {};

    exercisesForDaysJson.forEach((day, exercisesJson) {
      List<ExerciseModel> exercises = [];
      List<Map<String, dynamic>> jsonExercises =
          List<Map<String, dynamic>>.from(exercisesJson);
      exercises = (jsonExercises)
          .map((exercise) => ExerciseModel.fromJson(exercise))
          .toList();

      exercisesForDays[day] = exercises;
    });

    return WorkoutsPlanModel(
      planName: json['plan_name'],
      exercisesForDays: exercisesForDays,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plan_name': planName,
      'exercises_for_days': exercisesForDays.map((day, exercises) => MapEntry(
          day,
          exercises.map((exerciseToJson) => exerciseToJson.toJson()).toList())),
    };
  }
}

class ExerciseModel {
  int id;
  String title;
  String cover;
  String video1;
  String video2;
  String video3;
  String zone;
  String equipment;
  String description;
  int musclesId;
  String createdAt;
  String updatedAt;
  String setsReps;

  ExerciseModel({
    required this.id,
    required this.title,
    required this.cover,
    required this.video1,
    required this.video2,
    required this.video3,
    required this.zone,
    required this.equipment,
    required this.description,
    required this.musclesId,
    required this.createdAt,
    required this.updatedAt,
    required this.setsReps,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      cover: json['cover'] ?? "",
      video1: json['video1'] ?? "",
      video2: json['video2'] ?? "",
      video3: json['video3'] ?? "",
      zone: json['zone'] ?? "",
      equipment: json['equipment'] ?? "",
      description: json['description'] ?? "",
      musclesId: json['muscles_id'] ?? 0,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      setsReps: json['sets_reps'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'cover': cover,
      'video1': video1,
      'video2': video2,
      'video3': video3,
      'zone': zone,
      'equipment': equipment,
      'description': description,
      'muscles_id': musclesId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'sets_reps': setsReps,
    };
  }
}
