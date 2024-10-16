import 'package:gym/models/track_weight_reps.dart';

class Workout {
  String title;
  String equipment;
  String description;
  String focusZone;
  String imageUrl;
  bool isOpen;
  List<LbsAndRepsModel> lbsAndReps;

  Workout({
    required this.title,
    required this.equipment,
    required this.description,
    required this.focusZone,
    required this.imageUrl,
    required this.lbsAndReps,
    this.isOpen = false,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      title: json['title'] ?? '',
      equipment: json['Equipment'] ?? '',
      description: json['Description'] ?? '',
      focusZone: json['FoucsZone'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      lbsAndReps: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'equipment': equipment,
      'description': description,
      'focusZone': focusZone,
      'imageUrl': imageUrl,
      'lbsAndReps': [],
    };
  }
}

class TrackWorkout {
  String title;
  bool isOpen;
  List<LbsAndRepsModel> lbsAndReps;

  TrackWorkout({
    required this.title,
    required this.lbsAndReps,
    this.isOpen = false,
  });

  factory TrackWorkout.fromJson(Map<String, dynamic> json) {
    return TrackWorkout(
      title: json['title'] ?? '',
      // equipment: json['Equipment'] ?? '',
      // description: json['Description'] ?? '',
      // focusZone: json['FoucsZone'] ?? '',
      // imageUrl: json['imageUrl'] ?? '',
      lbsAndReps: (json['lbsAndReps'] as List<dynamic>?)
              ?.map((e) => LbsAndRepsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      // 'equipment': equipment,
      // 'description': description,
      // 'focusZone': focusZone,
      // 'imageUrl': imageUrl,
      'lbsAndReps': lbsAndReps
          .map((lbsAndRepsModel) => lbsAndRepsModel.toJson())
          .toList(),
    };
  }
}
