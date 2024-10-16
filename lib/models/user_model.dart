class UserModel {
  String id;
  String name;
  String email;
  String role;
  DateTime? twoFactorConfirmedAt;
  int reminderOnPlan;
  int reminderOnFood;
  String phone;
  int status;
  int height;
  int weight;
  int age;
  String zone;
  String job;
  String jobHours;
  String dailyActivity;
  String sleepTime;
  String wakeupTime;
  bool trainedBefore;
  String howMuchDidYouExercise;
  String exercisesType;
  bool seeResults;
  String feedback;
  String favFood;
  String unfavFood;
  String eatingTimes;
  String homeStreet;
  String target;
  String offlineOnline;
  String madeFood;
  String dietIssues;
  String firstDiet;
  String dietResult;
  String extra;
  DateTime? emailVerifiedAt;
  String profilePhotoPath;
  DateTime createdAt;
  DateTime updatedAt;
  int newReminderOnPlan;
  int newReminderOnFood;
  DateTime enrollmentExpireDate;
  DateTime enrollmentStartDate;
  String checkInEveryDate;
  String followUpDate;
  String profilePhotoUrl;
  String chronicDiseases;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.twoFactorConfirmedAt,
    required this.reminderOnPlan,
    required this.reminderOnFood,
    required this.phone,
    required this.status,
    required this.height,
    required this.weight,
    required this.age,
    required this.zone,
    required this.job,
    required this.jobHours,
    required this.dailyActivity,
    required this.sleepTime,
    required this.wakeupTime,
    required this.trainedBefore,
    required this.howMuchDidYouExercise,
    required this.exercisesType,
    required this.seeResults,
    required this.feedback,
    required this.favFood,
    required this.unfavFood,
    required this.eatingTimes,
    required this.homeStreet,
    required this.target,
    required this.offlineOnline,
    required this.madeFood,
    required this.dietIssues,
    required this.firstDiet,
    required this.dietResult,
    required this.extra,
    required this.emailVerifiedAt,
    required this.profilePhotoPath,
    required this.createdAt,
    required this.updatedAt,
    required this.newReminderOnPlan,
    required this.newReminderOnFood,
    required this.enrollmentExpireDate,
    required this.enrollmentStartDate,
    required this.profilePhotoUrl,
    required this.followUpDate,
    required this.checkInEveryDate,
    required this.chronicDiseases,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      role: json['role'] ?? "",
      twoFactorConfirmedAt: json['two_factor_confirmed_at'] != null
          ? DateTime.parse(json['two_factor_confirmed_at'])
          : null,
      reminderOnPlan: json['reminder_on_plan'] ?? 0,
      reminderOnFood: json['reminder_on_food'] ?? 0,
      phone: json['phone'] ?? "",
      status: json['status'] ?? 0,
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      age: json['age'] ?? 0,
      zone: json['zone'] ?? "",
      job: json['job'] ?? "",
      jobHours: json['job_hours'] ?? "",
      dailyActivity: json['daily_activity'] ?? "",
      sleepTime: json['sleep_time'] ?? "",
      wakeupTime: json['wakeup_time'] ?? "",
      trainedBefore: json['trained_before'] == 1 ? true : false,
      howMuchDidYouExercise: json['How_much_did_you_exercise'] ?? "",
      exercisesType: json['exercises_type'] ?? "",
      seeResults: json['see_results'] == 1 ? true : false,
      feedback: json['feedback'] ?? "",
      favFood: json['fav_food'] ?? "",
      unfavFood: json['unfav_food'] ?? "",
      eatingTimes: json['eating_times'] ?? "",
      homeStreet: json['home_street'] ?? "",
      target: json['traget'] ?? "",
      offlineOnline: json['offline_online'] ?? "",
      madeFood: json['made_food'] ?? "",
      dietIssues: json['diet_issues'] ?? "",
      firstDiet: json['first_diet'] ?? "",
      dietResult: json['diet_result'] ?? "",
      extra: json['extra'] ?? "",
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      profilePhotoPath: json['profile_photo_path'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      newReminderOnPlan: json['new_reminder_on_plan'] ?? 0,
      newReminderOnFood: json['new_reminder_on_food'] ?? 0,
      enrollmentExpireDate: DateTime.parse(json['enrollment_expire_date']),
      enrollmentStartDate: DateTime.parse(json['enrollment_start_date']),
      profilePhotoUrl: json['profile_photo_path'] ?? "",
      checkInEveryDate: json['check_in_every'] ?? "",
      followUpDate: json['followUp'] ?? "",
      chronicDiseases: json['chronic_diseases'] ?? "",
    );
  }

  factory UserModel.emptyUser() {
    return UserModel(
      id: "0",
      name: '',
      email: '',
      role: '',
      twoFactorConfirmedAt: null,
      reminderOnPlan: 0,
      reminderOnFood: 0,
      phone: '',
      status: 0,
      height: 0,
      weight: 0,
      age: 0,
      zone: '',
      job: '',
      jobHours: '',
      dailyActivity: '',
      sleepTime: '',
      wakeupTime: '',
      trainedBefore: false,
      howMuchDidYouExercise: '',
      exercisesType: '',
      seeResults: false,
      feedback: '',
      favFood: '',
      unfavFood: '',
      eatingTimes: '',
      homeStreet: '',
      target: '',
      offlineOnline: '',
      madeFood: '',
      dietIssues: '',
      firstDiet: '',
      dietResult: '',
      extra: '',
      emailVerifiedAt: null,
      profilePhotoPath: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      newReminderOnPlan: 0,
      newReminderOnFood: 0,
      enrollmentExpireDate: DateTime.now(),
      enrollmentStartDate: DateTime.now(),
      profilePhotoUrl: '',
      followUpDate: '',
      checkInEveryDate: '',
      chronicDiseases: "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'two_factor_confirmed_at': twoFactorConfirmedAt?.toIso8601String(),
      'reminder_on_plan': reminderOnPlan,
      'reminder_on_food': reminderOnFood,
      'phone': phone,
      'status': status,
      'height': height,
      'weight': weight,
      'age': age,
      'zone': zone,
      'job': job,
      'job_hours': jobHours,
      'daily_activity': dailyActivity,
      'sleep_time': sleepTime,
      'wakeup_time': wakeupTime,
      'trained_before': trainedBefore,
      'How_much_did_you_exercise': howMuchDidYouExercise,
      'exercises_type': exercisesType,
      'see_results': seeResults,
      'feedback': feedback,
      'fav_food': favFood,
      'unfav_food': unfavFood,
      'eating_times': eatingTimes,
      'home_street': homeStreet,
      'traget': target,
      'offline_online': offlineOnline,
      'made_food': madeFood,
      'diet_issues': dietIssues,
      'first_diet': firstDiet,
      'diet_result': dietResult,
      'extra': extra,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'profile_photo_path': profilePhotoPath,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'new_reminder_on_plan': newReminderOnPlan,
      'new_reminder_on_food': newReminderOnFood,
      'enrollment_expire_date': enrollmentExpireDate.toIso8601String(),
      'enrollment_start_date': enrollmentStartDate.toIso8601String(),
      'profile_photo_url': profilePhotoUrl,
      'followUp': followUpDate,
      'check_in_every': checkInEveryDate,
      "chronic_diseases": chronicDiseases,
    };
  }
}
