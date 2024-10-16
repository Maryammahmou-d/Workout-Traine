import 'package:flutter/widgets.dart';

import '../blocs/localization/localization/app_localization.dart';
import 'constants.dart';

extension Locale on String {
  String getLocale(BuildContext context) {
    return AppLocalizations.of(context)?.translate(this) ?? this;
  }
}

extension ResponsiveText on double {
  double sp(BuildContext context) {
    double calculatedSize =
        (this / 720) * AppConstants.screenSize(context).height;
    if (AppConstants.screenSize(context).height < 600) {
      return calculatedSize.clamp(this - 4, this);
    } else if (AppConstants.screenSize(context).height > 1080) {
      return calculatedSize.clamp(this, this + 2);
    } else {
      double calculatedSize =
          (this / 720) * AppConstants.screenSize(context).height;
      return calculatedSize.clamp(this - 2, this);
    }
  }
}
