import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:gym/models/food_item.dart';
import 'package:gym/shared/extentions.dart';

import '../../../shared/constants.dart';
import '../../../shared/widgets/navigation_card.dart';
import '../../../style/colors.dart';

class PolygonContainer extends StatelessWidget {
  const PolygonContainer({
    super.key,
    required this.symbol,
    required this.fullText,
  });

  final String symbol;
  final String fullText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 22,
          width: 22,
          decoration: const ShapeDecoration(
            shape: PolygonBorder(
              sides: 6,
              borderRadius: 5.0,
              rotate: 90.0,
              side: BorderSide(
                color: AppColors.darkGrey,
                width: 1,
              ),
            ),
          ),
          child: Center(
            child: Text(
              symbol,
              style: AppConstants.textTheme(context).labelLarge!.copyWith(
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            top: 2.0,
            right: 2,
          ),
        ),
        Text(
          fullText,
          style: AppConstants.textTheme(context).bodySmall!.copyWith(
                color: AppColors.darkGrey,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}

class FoodCard extends StatefulWidget {
  const FoodCard({
    super.key,
    required this.meal,
  });

  final Food meal;

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  late Food currentMeal;
  @override
  void initState() {
    currentMeal = widget.meal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationCard(
      setName: currentMeal.name,
      numOfWorkouts: '',
      imgUrl: currentMeal.image ?? "",
      descWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
            child: Text(
              '${"weight".getLocale(context)}: ${currentMeal.weight} ${currentMeal.name.contains("egg") ? "" : "g".getLocale(context)}',
              style: AppConstants.textTheme(context).bodyMedium!.copyWith(
                    color: AppColors.darkGrey,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          // SizedBox(
          //   width: AppConstants.screenSize(context).width - 168,
          //   child: Wrap(
          //     direction: Axis.horizontal,
          //     crossAxisAlignment: WrapCrossAlignment.start,
          //     alignment: WrapAlignment.start,
          //     runAlignment: WrapAlignment.start,
          //     spacing: 6,
          //     runSpacing: 6,
          //     children: [
          //       if (currentMeal.protein != '0')
          //         PolygonContainer(
          //           fullText: currentMeal.protein,
          //           symbol: "P",
          //         ),
          //       if (currentMeal.carbs != '0')
          //         PolygonContainer(
          //           fullText: currentMeal.carbs,
          //           symbol: "C",
          //         ),
          //       if (currentMeal.fat != '0')
          //         PolygonContainer(
          //           fullText: currentMeal.fat,
          //           symbol: "F",
          //         ),
          //     ],
          //   ),
          // ),
        ],
      ),
      onTap: () {
        // Navigate(
        //   context: context,
        //   screen: FoodDetailsScreen(
        //     hero: '${currentMeal.id}',
        //     title: currentMeal.name,
        //     imageUrl: currentMeal.image ?? "",
        //   ),
        // ).to();
      },
      suffixWidget: widget.meal.alternatives.isNotEmpty
          ? InkWell(
              onTap: () {
                setState(() {
                  widget.meal.alternatives.add(currentMeal);
                  currentMeal = widget.meal.alternatives[0];
                  widget.meal.alternatives.removeAt(0);
                });
              },
              child: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.mainColor.withOpacity(0.3),
                ),
                child: const Center(
                  child: Icon(
                    Icons.repeat,
                    color: AppColors.darkerMainColor,
                    size: 18,
                  ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
