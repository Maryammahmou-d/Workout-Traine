class TipsAndTricksModel {
  int id;
  String name;
  String content;
  String type;
  String? img;
  String cover;
  String? video;
  DateTime createdAt;
  DateTime updatedAt;

  TipsAndTricksModel({
    required this.id,
    required this.name,
    required this.content,
    required this.type,
    this.img,
    required this.cover,
    this.video,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TipsAndTricksModel.fromJson(Map<String, dynamic> json) {
    return TipsAndTricksModel(
      id: json['id'],
      name: json['name'],
      content: json['content'],
      type: json['type'],
      img: json['img'],
      cover: json['cover'],
      video: json['video'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
