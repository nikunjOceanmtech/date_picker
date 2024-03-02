import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as intl;

import '../shared/picker_grid_delegate.dart';

const double _dayPickerRowHeight = 52.0;

class DaysView extends StatelessWidget {
  DaysView({
    super.key,
    required this.currentDate,
    required this.onChanged,
    required this.minDate,
    required this.maxDate,
    this.selectedDate,
    required this.displayedMonth,
    required this.daysOfTheWeekTextStyle,
    required this.enabledCellsTextStyle,
    required this.enabledCellsDecoration,
    required this.disbaledCellsTextStyle,
    required this.disbaledCellsDecoration,
    required this.currentDateTextStyle,
    required this.currentDateDecoration,
    required this.selectedDayTextStyle,
    required this.selectedDayDecoration,
    required this.highlightColor,
    required this.splashColor,
    this.splashRadius,
  })  : assert(!minDate.isAfter(maxDate), "minDate can't be after maxDate"),
        assert(() {
          if (selectedDate == null) return true;
          return (selectedDate.isAfter(minDate) || selectedDate.isAtSameMomentAs(minDate)) &&
              (selectedDate.isBefore(maxDate) || selectedDate.isAtSameMomentAs(maxDate));
        }(), "selected date should be in the range of min date & max date");

  final DateTime? selectedDate;
  final DateTime currentDate;
  final ValueChanged<DateTime> onChanged;
  final DateTime minDate;
  final DateTime maxDate;
  final DateTime displayedMonth;
  final TextStyle daysOfTheWeekTextStyle;
  final TextStyle enabledCellsTextStyle;
  final BoxDecoration enabledCellsDecoration;
  final TextStyle disbaledCellsTextStyle;
  final BoxDecoration disbaledCellsDecoration;
  final TextStyle currentDateTextStyle;
  final BoxDecoration currentDateDecoration;
  final TextStyle selectedDayTextStyle;
  final BoxDecoration selectedDayDecoration;
  final Color splashColor;
  final Color highlightColor;
  final double? splashRadius;

  List<Widget> _dayHeaders(
    TextStyle headerStyle,
    Locale locale,
    MaterialLocalizations localizations,
  ) {
    final List<Widget> result = <Widget>[];
    final weekdayNames = intl.DateFormat('', locale.toString()).dateSymbols.SHORTWEEKDAYS;

    for (int i = localizations.firstDayOfWeekIndex; true; i = (i + 1) % 7) {
      final String weekday = weekdayNames[i].replaceFirst('ال', '');
      result.add(
        ExcludeSemantics(
          child: Center(
            child: Text(
              weekday.toUpperCase(),
              style: daysOfTheWeekTextStyle,
            ),
          ),
        ),
      );
      if (i == (localizations.firstDayOfWeekIndex - 1) % 7) {
        break;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);

    final int year = displayedMonth.year;
    final int month = displayedMonth.month;
    final int daysInMonth = DateUtils.getDaysInMonth(year, month);
    final int dayOffset = DateUtils.firstDayOffset(year, month, localizations);

    final List<Widget> dayItems = _dayHeaders(
      daysOfTheWeekTextStyle,
      Localizations.localeOf(context),
      MaterialLocalizations.of(context),
    );

    int day = -dayOffset;
    while (day < daysInMonth) {
      day++;
      if (day < 1) {
        dayItems.add(const SizedBox.shrink());
      } else {
        final DateTime dayToBuild = DateTime(year, month, day);
        final bool isDisabled = dayToBuild.isAfter(maxDate) || dayToBuild.isBefore(minDate);
        final bool isSelectedDay = DateUtils.isSameDay(selectedDate, dayToBuild);

        final bool isCurrent = DateUtils.isSameDay(currentDate, dayToBuild);
        BoxDecoration decoration = enabledCellsDecoration;
        TextStyle style = enabledCellsTextStyle;

        if (isCurrent) {
          style = currentDateTextStyle;
          decoration = currentDateDecoration;
        }

        if (isSelectedDay) {
          style = selectedDayTextStyle;
          decoration = selectedDayDecoration;
        }

        if (isDisabled) {
          style = disbaledCellsTextStyle;
          decoration = disbaledCellsDecoration;
        }

        if (isCurrent && isDisabled) {
          style = const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
          decoration = currentDateDecoration;
        }

        Widget dayWidget = Container(
          decoration: decoration,
          child: Center(
            child: Text(
              localizations.formatDecimal(day),
              style: style,
            ),
          ),
        );

        if (isDisabled) {
          dayWidget = ExcludeSemantics(
            child: dayWidget,
          );
        } else {
          dayWidget = InkResponse(
            onTap: () => onChanged(dayToBuild),
            radius: splashRadius ?? _dayPickerRowHeight / 2 + 4,
            splashColor: splashColor,
            highlightColor: highlightColor,
            child: Semantics(
              label: '${localizations.formatDecimal(day)}, ${localizations.formatFullDate(dayToBuild)}',
              selected: isSelectedDay,
              excludeSemantics: true,
              child: dayWidget,
            ),
          );
        }

        dayItems.add(dayWidget);
      }
    }

    return GridView.custom(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const PickerGridDelegate(
        columnCount: DateTime.daysPerWeek,
        columnPadding: 4,
        rowPadding: 4,
        rowExtent: _dayPickerRowHeight,
        rowStride: _dayPickerRowHeight,
      ),
      childrenDelegate: SliverChildListDelegate(
        addRepaintBoundaries: false,
        dayItems,
      ),
    );
  }
}
