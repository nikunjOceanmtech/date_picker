import 'package:date_picker_plus/src/shared/leading_date.dart';
import 'package:flutter/cupertino.dart';

class PageSliders extends StatelessWidget {
  final VoidCallback onForward;
  final VoidCallback onBackward;
  final Color slidersColor;
  final double slidersSized;
  final VoidCallback onDateTap;
  final String displayedDate;
  final TextStyle leadingDateTextStyle;

  const PageSliders({
    Key? key,
    required this.onForward,
    required this.onBackward,
    required this.slidersColor,
    required this.slidersSized,
    required this.onDateTap,
    required this.displayedDate,
    required this.leadingDateTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onBackward,
            child: SizedBox(
              width: 36,
              height: 36,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  CupertinoIcons.chevron_left,
                  size: slidersSized,
                  color: slidersColor,
                ),
              ),
            ),
          ),
          LeadingDate(
            onTap: onDateTap,
            displayedText: displayedDate,
            displayedTextStyle: leadingDateTextStyle,
          ),
          GestureDetector(
            onTap: onForward,
            child: SizedBox(
              width: 36,
              height: 36,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  CupertinoIcons.chevron_right,
                  size: slidersSized,
                  color: slidersColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
