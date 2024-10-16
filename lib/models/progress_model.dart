class ProgressModel {
  final String video;
  final String message;

  ProgressModel({
    required this.video,
    required this.message,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json,
      {bool isVideo = false}) {
    return ProgressModel(
      video: (isVideo ? json['video'] : json['image']) ?? '',
      message: json['message'] ?? '',
    );
  }
}
