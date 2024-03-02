import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../shared/header.dart';
import 'range_days_view.dart';

class RangeDaysPicker extends StatefulWidget {
  RangeDaysPicker({
    super.key,
    required this.minDate,
    required this.maxDate,
    this.initialDate,
    this.currentDate,
    this.selectedStartDate,
    this.selectedEndDate,
    this.daysOfTheWeekTextStyle,
    this.enabledCellsTextStyle,
    this.enabledCellsDecoration = const BoxDecoration(),
    this.disbaledCellsTextStyle,
    this.disbaledCellsDecoration = const BoxDecoration(),
    this.currentDateTextStyle,
    this.currentDateDecoration,
    this.selectedCellsTextStyle,
    this.selectedCellsDecoration,
    this.singelSelectedCellTextStyle,
    this.singelSelectedCellDecoration,
    this.onLeadingDateTap,
    this.onStartDateChanged,
    this.onEndDateChanged,
    this.leadingDateTextStyle,
    this.slidersColor,
    this.slidersSize,
    this.highlightColor,
    this.splashColor,
    this.splashRadius,
    this.applyButtonTextStyle,
    this.applyButtonBoxDecoration,
    this.cancelButtonBoxDecoration,
    this.cancelButtonTextStyle,
    this.twoButtonCenterSpace,
    this.calcelButtonText,
    this.okButtonText,
    this.applyButtonColor,
    this.cancelButtonColor,
    this.onRangeSelected,
  }) {
    assert(!minDate.isAfter(maxDate), "minDate can't be after maxDate");

    assert(
      () {
        if (initialDate == null) return true;
        final init = DateTime(initialDate!.year, initialDate!.month);

        final min = DateTime(minDate.year, minDate.month);

        return init.isAfter(min) || init.isAtSameMomentAs(min);
      }(),
      'initialDate $initialDate must be on or after minDate $minDate.',
    );
    assert(
      () {
        if (initialDate == null) return true;
        final init = DateTime(initialDate!.year, initialDate!.month);

        final max = DateTime(maxDate.year, maxDate.month);
        return init.isBefore(max) || init.isAtSameMomentAs(max);
      }(),
      'initialDate $initialDate must be on or before maxDate $maxDate.',
    );
  }

  final DateTime? initialDate;
  final DateTime? currentDate;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final ValueChanged<DateTime>? onStartDateChanged;
  final ValueChanged<DateTime>? onEndDateChanged;
  final DateTime minDate;
  final DateTime maxDate;
  final VoidCallback? onLeadingDateTap;
  final TextStyle? daysOfTheWeekTextStyle;
  final TextStyle? enabledCellsTextStyle;
  final BoxDecoration enabledCellsDecoration;
  final TextStyle? disbaledCellsTextStyle;
  final BoxDecoration disbaledCellsDecoration;
  final TextStyle? currentDateTextStyle;
  final BoxDecoration? currentDateDecoration;
  final TextStyle? selectedCellsTextStyle;
  final BoxDecoration? selectedCellsDecoration;
  final TextStyle? singelSelectedCellTextStyle;
  final BoxDecoration? singelSelectedCellDecoration;
  final TextStyle? leadingDateTextStyle;
  final Color? slidersColor;
  final double? slidersSize;
  final Color? splashColor;
  final Color? highlightColor;
  final double? splashRadius;
  final TextStyle? applyButtonTextStyle;
  final BoxDecoration? applyButtonBoxDecoration;
  final TextStyle? cancelButtonTextStyle;
  final BoxDecoration? cancelButtonBoxDecoration;
  final double? twoButtonCenterSpace;
  final String? calcelButtonText;
  final String? okButtonText;
  final Color? applyButtonColor;
  final Color? cancelButtonColor;
  final ValueChanged<DateTimeRange>? onRangeSelected;

  @override
  State<RangeDaysPicker> createState() => __RangeDaysPickerState();
}

class __RangeDaysPickerState extends State<RangeDaysPicker> {
  DateTime? _displayedMonth;
  final GlobalKey _pageViewKey = GlobalKey();
  late final PageController _pageController;
  double maxHeight = 52 * 7;

  @override
  void initState() {
    _displayedMonth = widget.initialDate ?? DateUtils.dateOnly(DateTime.now());
    _pageController = PageController(
      initialPage: DateUtils.monthDelta(widget.minDate, _displayedMonth!),
    );
    super.initState();
  }

  @override
  void didUpdateWidget(covariant RangeDaysPicker oldWidget) {
    if (oldWidget.initialDate != widget.initialDate) {
      _displayedMonth = widget.initialDate ?? DateUtils.dateOnly(DateTime.now());
      _pageController.jumpToPage(
        DateUtils.monthDelta(widget.minDate, _displayedMonth!),
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final TextStyle daysOfTheWeekTextStyle = widget.daysOfTheWeekTextStyle ??
        textTheme.titleSmall!.copyWith(
          color: colorScheme.onSurface.withOpacity(0.30),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        );

    final TextStyle enabledCellsTextStyle = widget.enabledCellsTextStyle ??
        textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.normal,
          color: colorScheme.onSurface,
        );

    final BoxDecoration enabledCellsDecoration = widget.enabledCellsDecoration;

    final TextStyle disbaledCellsTextStyle = widget.disbaledCellsTextStyle ??
        textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.normal,
          color: colorScheme.onSurface.withOpacity(0.30),
        );

    final BoxDecoration disbaledCellsDecoration = widget.disbaledCellsDecoration;

    final TextStyle currentDateTextStyle = widget.currentDateTextStyle ??
        textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.normal,
          color: colorScheme.primary,
        );

    final BoxDecoration currentDateDecoration = widget.currentDateDecoration ??
        BoxDecoration(
          border: Border.all(color: colorScheme.primary),
          shape: BoxShape.circle,
        );

    final TextStyle selectedCellsTextStyle = widget.selectedCellsTextStyle ??
        textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.normal,
          color: colorScheme.onPrimaryContainer,
        );

    final BoxDecoration selectedCellsDecoration = widget.selectedCellsDecoration ??
        BoxDecoration(
          color: colorScheme.primaryContainer,
          shape: BoxShape.rectangle,
        );

    final TextStyle singelSelectedCellTextStyle = widget.singelSelectedCellTextStyle ??
        textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.normal,
          color: colorScheme.onPrimary,
        );

    final BoxDecoration singelSelectedCellDecoration = widget.singelSelectedCellDecoration ??
        BoxDecoration(
          color: colorScheme.primary,
          shape: BoxShape.circle,
        );

    final leadingDateTextStyle = widget.leadingDateTextStyle ??
        TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: colorScheme.primary,
        );

    final slidersColor = widget.slidersColor ?? colorScheme.primary;
    final slidersSize = widget.slidersSize ?? 20;
    final splashColor =
        widget.splashColor ?? selectedCellsDecoration.color?.withOpacity(0.3) ?? colorScheme.primary.withOpacity(0.3);

    final highlightColor = widget.highlightColor ?? Theme.of(context).highlightColor;
    String weekdayName = DateFormat('EEEE').format(_displayedMonth!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Header(
          leadingDateTextStyle: leadingDateTextStyle,
          slidersColor: slidersColor,
          slidersSize: slidersSize,
          onDateTap: () => widget.onLeadingDateTap?.call(),
          displayedDate: MaterialLocalizations.of(context)
              .formatMonthYear(_displayedMonth!)
              .replaceAll('٩', '9')
              .replaceAll('٨', '8')
              .replaceAll('٧', '7')
              .replaceAll('٦', '6')
              .replaceAll('٥', '5')
              .replaceAll('٤', '4')
              .replaceAll('٣', '3')
              .replaceAll('٢', '2')
              .replaceAll('١', '1')
              .replaceAll('٠', '0'),
          onNextPage: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          onPreviousPage: () {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ),
        const SizedBox(height: 10),
        AnimatedContainer(
          height: weekdayName == "Saturday" ||
                  (weekdayName == "Friday" &&
                      getDaysInMonth(year: _displayedMonth!.year, month: _displayedMonth!.month) == 31)
              ? 370
              : 320,
          duration: const Duration(milliseconds: 200),
          constraints: const BoxConstraints(maxHeight: 370, minHeight: 100),
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            key: _pageViewKey,
            controller: _pageController,
            itemCount: DateUtils.monthDelta(widget.minDate, widget.maxDate) + 1,
            onPageChanged: (monthPage) {
              final DateTime monthDate = DateUtils.addMonthsToMonthDate(widget.minDate, monthPage);

              setState(() {
                _displayedMonth = monthDate;
              });
            },
            itemBuilder: (context, index) {
              final DateTime month = DateUtils.addMonthsToMonthDate(widget.minDate, index);
              return RangeDaysView(
                key: ValueKey<DateTime>(month),
                currentDate: widget.currentDate ?? DateUtils.dateOnly(DateTime.now()),
                minDate: widget.minDate,
                maxDate: widget.maxDate,
                displayedMonth: month,
                selectedEndDate: widget.selectedEndDate,
                selectedStartDate: widget.selectedStartDate,
                daysOfTheWeekTextStyle: daysOfTheWeekTextStyle,
                enabledCellsTextStyle: enabledCellsTextStyle,
                enabledCellsDecoration: enabledCellsDecoration,
                disbaledCellsTextStyle: disbaledCellsTextStyle,
                disbaledCellsDecoration: disbaledCellsDecoration,
                currentDateDecoration: currentDateDecoration,
                currentDateTextStyle: currentDateTextStyle,
                selectedCellsDecoration: selectedCellsDecoration,
                selectedCellsTextStyle: selectedCellsTextStyle,
                singelSelectedCellTextStyle: singelSelectedCellTextStyle,
                singelSelectedCellDecoration: singelSelectedCellDecoration,
                highlightColor: highlightColor,
                splashColor: splashColor,
                splashRadius: widget.splashRadius,
                onEndDateChanged: (value) => widget.onEndDateChanged?.call(value),
                onStartDateChanged: (value) => widget.onStartDateChanged?.call(value),
              );
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: widget.cancelButtonBoxDecoration ??
                      BoxDecoration(
                        color: widget.cancelButtonColor ?? const Color(0xffFFDDC0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                  child: Text(
                    "Cancel",
                    style: widget.cancelButtonTextStyle ??
                        const TextStyle(
                          color: Color(0xffB75400),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
            SizedBox(width: widget.twoButtonCenterSpace ?? 10),
            Expanded(
              child: InkWell(
                onTap: () {
                  //   Navigator.pop(context, DateTimeRange(start: startingDate!, end: endingDate!));
                  if (startingDate != null && endingDate != null) {
                    Navigator.pop(context, DateTimeRange(start: startingDate!, end: endingDate!));
                  } else {
                    print('select start and end date');
                  }
                },
                child: Container(
                  height: 50,
                  decoration: widget.applyButtonBoxDecoration ??
                      BoxDecoration(
                        color: widget.applyButtonColor ?? const Color(0xffB75400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                  alignment: Alignment.center,
                  child: Text(
                    "Apply",
                    style: widget.applyButtonTextStyle ??
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

int getDaysInMonth({required int year, required int month}) {
  if (month == DateTime.february) {
    final bool isLeapYear = (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
    return isLeapYear ? 29 : 28;
  }
  const List<int> daysInMonth = [31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  return daysInMonth[month - 1];
}
