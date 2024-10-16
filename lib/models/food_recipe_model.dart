class FoodRecipesModel {
  int id;
  String name;
  String? img;
  String? video;
  List<String> ingredients;
  String instructions;
  String? createdAt;
  String updatedAt;

  FoodRecipesModel({
    required this.id,
    required this.name,
    this.img,
    this.video,
    required this.ingredients,
    required this.instructions,
    this.createdAt,
    required this.updatedAt,
  });

  factory FoodRecipesModel.fromJson(Map<String, dynamic> json) {
    return FoodRecipesModel(
      id: json['id'] ,
      name: json['name'],
      img: json['img'],
      video: json['video'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: json['instructions'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
