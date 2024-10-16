import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gym/shared/widgets/video_player.dart';

import '../../../shared/constants.dart';
import '../../../shared/widgets/shared_widgets.dart';
import '../../../style/colors.dart';

class TipsAndTripsDetailsScreen extends StatelessWidget {
  const TipsAndTripsDetailsScreen(
      {super.key, required this.title, this.img, this.videoUrl});
  final String title;
  final String? img;
  final String? videoUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: DefaultContainerWithAppBar(
          screenTitle: '',
          withBackArrow: true,
          children: [
            if (videoUrl != null)
              SizedBox(
                  width: AppConstants.screenSize(context).width,
                  height: AppConstants.screenSize(context).height * 0.6,
                  child: DefaultVideoPlayer(videoUrl: videoUrl!)),
            if (img != null)
              CachedNetworkImage(
                imageUrl: img!,
                width: AppConstants.screenSize(context).width,
                height: AppConstants.screenSize(context).height * 0.6,
              ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                top: 20.0,
                // bottom: 12,
              ),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.mainBlack,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
