import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym/shared/constants.dart';
import 'package:gym/shared/extentions.dart';
import 'package:gym/shared/widgets/video_player.dart';

import '../../../../models/food_recipe_model.dart';
import '../../../../style/colors.dart';

class FoodDetailsScreen extends StatelessWidget {
  const FoodDetailsScreen({
    super.key,
    required this.recipesModel,
  });
  final FoodRecipesModel recipesModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          BuildSliverAppBar(
            hero: "recipes${recipesModel.id}",
            imageUrl: recipesModel.img ?? "",
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              addRepaintBoundaries: true,
              [
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    width: AppConstants.screenSize(context).width,
                    constraints: BoxConstraints(
                      minHeight: AppConstants.screenSize(context).height * 0.5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.16),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 28,
                          ),
                          Text(
                            recipesModel.name,
                            style: AppConstants.textTheme(context)
                                .titleLarge!
                                .copyWith(
                              fontSize: 32,
                                  color: AppColors.oldMainColor,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'ingredients'.getLocale(context),
                            style: AppConstants.textTheme(context)
                                .titleMedium!
                                .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ...List.generate(
                            recipesModel.ingredients.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: DottedPoint(
                                point: recipesModel.ingredients[index],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'method'.getLocale(context),
                            style: AppConstants.textTheme(context)
                                .titleMedium!
                                .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              recipesModel.instructions,
                              textAlign: TextAlign.right,
                              style: AppConstants.textTheme(context)
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                          if (recipesModel.video != null)
                            SizedBox(
                              height:
                                  AppConstants.screenSize(context).height * 0.5,
                              width: AppConstants.screenSize(context).width,
                              child: DefaultVideoPlayer(
                                videoUrl: recipesModel.video!,
                              ),
                            ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DottedPoint extends StatelessWidget {
  const DottedPoint({
    super.key,
    required this.point,
  });

  final String point;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 4,
        ),
        const Icon(
          Icons.circle,
          color: Colors.black,
          size: 6,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          point,
          textAlign: TextAlign.left,
          style: AppConstants.textTheme(context).bodyMedium!.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}

class BuildSliverAppBar extends StatelessWidget {
  const BuildSliverAppBar({
    super.key,
    required this.imageUrl,
    required this.hero,
  });

  final String imageUrl;
  final String hero;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 375,
      pinned: false,
      stretch: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: hero,
          child: AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              errorWidget: (context, url, error) => SvgPicture.asset(
                'assets/placeholder_img.svg',
              ),
              fit: BoxFit.fill,
              width: AppConstants.screenSize(context).width,
            ),
          ),
        ),
      ),
    );
  }
}
