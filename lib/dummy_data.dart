import 'package:gym/presentation/main_screens/food/food_screen.dart';
import 'package:gym/presentation/main_screens/food/recipes/cooking_recipes_screen.dart';
import 'package:gym/presentation/main_screens/progress/my_progress_screen.dart';
import 'package:gym/presentation/main_screens/progress/my_technique_screen.dart';
import 'package:gym/presentation/main_screens/settings/settings_screen.dart';
import 'package:gym/presentation/main_screens/subscription/subscription_screen.dart';
import 'package:gym/presentation/main_screens/tips_and_tricks/tips_and_tricks_screen.dart';

List<Map<String, dynamic>> homeScreenGrid = [
  {
    "title": "startWorkout",
    "imageUrl": "assets/images/home/workout_bg.jpg",
  },
  {
    "title": "foodDiary",
    "imageUrl": "assets/images/home/food_bg.jpg",
    'screen': const FoodScreen(),
  },
  {
    "title": "tipsAndTricks",
    "imageUrl": "assets/images/home/my_progress_bg.jpg",
    'screen': const TipsAndTricksScreen(),
  },
  {
    "title": "cookingRecipes",
    "imageUrl": "assets/images/home/food_bg.jpg",
    'screen': const CookingRecipesScreen(),
  },
  {
    "title": "todoList",
    "imageUrl": "assets/images/home/todo_list.jpg",
  },
  {
    "title": "trackMyWeightsAndReps",
    "imageUrl": "assets/images/home/tracking_bg.jpg",
  },
  {
    "title": "myProgress",
    "imageUrl": "assets/images/home/my_progress_bg.jpg",
    'screen': const MyProgressScreen(),
  },
  {
    "title": "myTechnique",
    "imageUrl": "assets/images/home/posture-deivation.jpg",
    'screen': const MyTechniqueScreen(),
  },
  // {
  //   "title": "Supplements",
  //   'screen': const SupplementScreen(),
  //   "imageUrl": "assets/images/home/suppliment.jpg",
  // },
  {
    "title": "settings",
    'screen': const SettingsScreen(),
    "imageUrl": "assets/images/home/settings_bg.jpg",
  },
  {
    "title": 'subscription',
    "imageUrl": 'assets/images/home/credit_card.jpg',
    'screen': const SubscriptionScreen(),
  },
];
