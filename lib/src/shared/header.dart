import 'package:flutter/material.dart';
import 'page_sliders.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.displayedDate,
    required this.onDateTap,
    required this.onNextPage,
    required this.onPreviousPage,
    required this.slidersColor,
    required this.slidersSize,
    required this.leadingDateTextStyle,
  });

  final String displayedDate;
  final TextStyle leadingDateTextStyle;
  final VoidCallback onDateTap;
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  final Color slidersColor;
  final double slidersSize;

  @override
  Widget build(BuildContext context) {
    return PageSliders(
      onBackward: onPreviousPage,
      onForward: onNextPage,
      slidersSized: slidersSize,
      slidersColor: slidersColor,
      onDateTap: onDateTap,
      leadingDateTextStyle: leadingDateTextStyle,
      displayedDate: displayedDate,
    );
  }
}
