import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../style/Style.dart';

class SmoothIndicators extends StatelessWidget {
  final PageController pageController;
  final int indicatorsNumber;

  SmoothIndicators(
      {Key? key, required this.pageController, required this.indicatorsNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: 3,
      axisDirection: Axis.horizontal,
      effect: SlideEffect(
          spacing: 8.0,
          radius: 25,
          dotWidth: 16,
          dotHeight: 16.0,
          paintStyle: PaintingStyle.stroke,
          strokeWidth: 1.5,
          dotColor: Colors.grey,
          activeDotColor: secondColor),
    );
  }
}
