import 'package:flutter/cupertino.dart';
import 'package:internet_application/core/extensions/media_query.dart';

class ScreenDimensions {
  static const double smallScreen = 400;
  static const double mediumScreen = 450;
  static const double largeScreen = 600;

  static int getGridViewRowItemCount(BuildContext context) {
    double width = context.width;
    if (width <= smallScreen) {
      return 1;
    } else if (width >= smallScreen && width <= mediumScreen) {
      return 3;
    }
    return 4;
  }
}
