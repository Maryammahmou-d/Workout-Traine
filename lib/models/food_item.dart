
class FoodPlanModel {
  String planName;
  Map<String, List<Food>> foodsForDays;

  FoodPlanModel({
    required this.planName,
    required this.foodsForDays,
  });

  factory FoodPlanModel.fromJson(Map<String, dynamic> json) {
    return FoodPlanModel(
      planName: json['plan_name'],
      foodsForDays: (json['foods_for_days'] as Map<String, dynamic>).map(
        (key, value) {
          return MapEntry(
            key,
            (value as List<dynamic>).map((item) {
              return Food.fromJson(item);
            }).toList(),
          );
        },
      ),
    );
  }
    Map<String, dynamic> toJson() {
      return {
        'plan_name': planName,
        'foods_for_days': foodsForDays.map(
              (key, value) => MapEntry(
            key,
            value.map((food) => food.toJson()).toList(),
          ),
        ),
      };
    }
  }

class Food {
  String name;
  String? image;
  List<Food> alternatives;
  String? weight;

  Food({
    required this.name,
    this.image,
    required this.alternatives,
    this.weight,
  });

  factory Food.fromJson(Map<String, dynamic> json, {double? weight}) {
    return Food(
      name: json['title'] ?? "",
      image: json['image'] ?? "",
      alternatives: [
        if (json['alternative1'] != null &&(json['alternative1'] as List).isNotEmpty)
          Food(
            name: json['alternative1'][0],
            image: json['alternative1'][1],
            weight: json['weights'].toString(),
            alternatives: [],
          ),
        if (json['alternative2'] != null &&(json['alternative2'] as List).isNotEmpty)
          Food(
            name: json['alternative2'][0],
            image: json['alternative2'][1],
            weight: json['weights'].toString(),
            alternatives: [],
          ),
        if (json['alternative3'] != null &&(json['alternative3'] as List).isNotEmpty)
          Food(
            name: json['alternative3'][0],
            image: json['alternative3'][1],
            weight: json['weights'].toString(),
            alternatives: [],
          ),
      ],
      weight: weight != null ? weight.toString() : json['weights'].toString(),
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'title': name,
      'image': image,
      'alternative1': [
        if (alternatives.isNotEmpty) alternatives[0].name,
        if (alternatives.isNotEmpty) alternatives[0].image,
      ],
      'alternative2': [
        if (alternatives.length > 1) alternatives[1].name,
        if (alternatives.length > 1) alternatives[1].image,
      ],
      'alternative3': [
        if (alternatives.length > 2) alternatives[2].name,
        if (alternatives.length > 2) alternatives[2].image,
      ],
      'weights': weight,
    };

    return json;
  }
}
