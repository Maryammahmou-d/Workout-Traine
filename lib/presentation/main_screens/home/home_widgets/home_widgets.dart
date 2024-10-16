import 'package:flutter/material.dart';

import '../../../../style/colors.dart';

class CircularContainerWithIcons extends StatelessWidget {
  const CircularContainerWithIcons({
    super.key,
    required this.onTap,
  });
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.lightGrey, // Background color of the circle
        ),
        child: const Stack(
          children: [
            Center(
              child: Icon(
                Icons.notifications_none_rounded,
                color: AppColors.mainColor,
                size: 24,
              ),
            ),
            // Positioned(
            //   top: 12,
            //   right: 12,
            //   child: Container(
            //     width: 4,
            //     height: 4,
            //     decoration: const BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: AppColors.mainColor,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
