import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../style/colors.dart';

class NavigationCard extends StatelessWidget {
  const NavigationCard({
    super.key,
    required this.setName,
    required this.numOfWorkouts,
    required this.imgUrl,
    required this.onTap,
    this.isWithNavArrow = true,
    this.isWithDesc = true,
    this.descWidget,
    this.suffixWidget,
  });

  final String setName;
  final String numOfWorkouts;
  final String imgUrl;
  final void Function() onTap;
  final bool isWithNavArrow;
  final bool isWithDesc;
  final Widget? descWidget;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width - 40,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width - 40,
height: 75,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  child: imgUrl.startsWith("assets")
                      ? Image.asset(
                          imgUrl,
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                        )
                      : CachedNetworkImage(
                          placeholder: (context, url) => SvgPicture.asset(
                            'assets/placeholder_img.svg',
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                          ),
                          errorWidget: (context, url, error) => SvgPicture.asset(
                            'assets/placeholder_img.svg',
                            height: 80,
                            width: 80,
                          ),
                          fit: BoxFit.cover,
                          imageUrl: imgUrl,
                          height: 80,
                          width: 80,
                        ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 185,

                      child: Text(
                        setName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppColors.mainBlack,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    if (isWithDesc)
                      descWidget ??
                          Text(
                            numOfWorkouts,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: AppColors.regularGrey,
                                      fontSize: 14,
                                    ),
                          ),
                  ],
                ),
                if (isWithNavArrow) const Spacer(),
                if (isWithNavArrow)
                  suffixWidget ??
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: AppColors.regularGrey,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
