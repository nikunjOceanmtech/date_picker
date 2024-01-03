import 'package:flutter/material.dart';

import '../shared/picker_type.dart';
import 'days_picker.dart';
import '../shared/month_picker.dart';
import '../shared/year_picker.dart';

class DatePicker extends StatefulWidget {
  DatePicker({
    super.key,
    required this.maxDate,
    required this.minDate,
    this.onDateSelected,
    this.initialDate,
    this.selectedDate,
    this.currentDate,
    this.padding = const EdgeInsets.all(16),
    this.initialPickerType = PickerType.days,
    this.daysOfTheWeekTextStyle,
    this.enabledCellsTextStyle,
    this.enabledCellsDecoration = const BoxDecoration(),
    this.disbaledCellsTextStyle,
    this.disbaledCellsDecoration = const BoxDecoration(),
    this.currentDateTextStyle,
    this.currentDateDecoration,
    this.selectedCellTextStyle,
    this.selectedCellDecoration,
    this.leadingDateTextStyle,
    this.slidersColor,
    this.slidersSize,
    this.highlightColor,
    this.splashColor,
    this.splashRadius,
  }) {
    assert(
      !maxDate.isBefore(minDate),
      'maxDate $maxDate must be on or after minDate $minDate.',
    );
  }

  final DateTime? initialDate;
  final DateTime? currentDate;
  final DateTime? selectedDate;
  final ValueChanged<DateTime>? onDateSelected;
  final DateTime minDate;
  final DateTime maxDate;
  final PickerType initialPickerType;
  final EdgeInsets padding;
  final TextStyle? daysOfTheWeekTextStyle;
  final TextStyle? enabledCellsTextStyle;
  final BoxDecoration enabledCellsDecoration;
  final TextStyle? disbaledCellsTextStyle;
  final BoxDecoration disbaledCellsDecoration;
  final TextStyle? currentDateTextStyle;
  final BoxDecoration? currentDateDecoration;
  final TextStyle? selectedCellTextStyle;
  final BoxDecoration? selectedCellDecoration;
  final TextStyle? leadingDateTextStyle;
  final Color? slidersColor;
  final double? slidersSize;
  final Color? splashColor;
  final Color? highlightColor;
  final double? splashRadius;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  PickerType? _pickerType;
  DateTime? _displayedDate;
  DateTime? _selectedDate;

  @override
  void initState() {
    _displayedDate = widget.initialDate ?? DateUtils.dateOnly(DateTime.now());
    _pickerType = widget.initialPickerType;
    _selectedDate = widget.selectedDate;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant DatePicker oldWidget) {
    if (oldWidget.initialDate != widget.initialDate) {
      _displayedDate = widget.initialDate ?? DateUtils.dateOnly(DateTime.now());
    }
    if (oldWidget.initialPickerType != widget.initialPickerType) {
      _pickerType = widget.initialPickerType;
    }
    if (oldWidget.selectedDate != widget.selectedDate) {
      _selectedDate = widget.selectedDate;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    switch (_pickerType!) {
      case PickerType.days:
        return Padding(
          padding: widget.padding,
          child: DaysPicker(
            initialDate: _displayedDate,
            selectedDate: _selectedDate,
            currentDate: widget.currentDate,
            maxDate: widget.maxDate,
            minDate: widget.minDate,
            daysOfTheWeekTextStyle: widget.daysOfTheWeekTextStyle,
            enabledCellsTextStyle: widget.enabledCellsTextStyle,
            enabledCellsDecoration: widget.enabledCellsDecoration,
            disbaledCellsTextStyle: widget.disbaledCellsTextStyle,
            disbaledCellsDecoration: widget.disbaledCellsDecoration,
            currentDateDecoration: widget.currentDateDecoration,
            currentDateTextStyle: widget.currentDateTextStyle,
            selectedCellDecoration: widget.selectedCellDecoration,
            selectedCellTextStyle: widget.selectedCellTextStyle,
            slidersColor: widget.slidersColor,
            slidersSize: widget.slidersSize,
            leadingDateTextStyle: widget.leadingDateTextStyle,
            splashColor: widget.splashColor,
            highlightColor: widget.highlightColor,
            splashRadius: widget.splashRadius,
            onDateSelected: (selectedDate) {
              setState(() {
                _displayedDate = selectedDate;
                _selectedDate = selectedDate;
              });
              widget.onDateSelected?.call(selectedDate);
            },
            onLeadingDateTap: () {
              setState(() {
                _pickerType = PickerType.months;
              });
            },
          ),
        );
      case PickerType.months:
        return Padding(
          padding: widget.padding,
          child: MonthPicker(
            initialDate: _displayedDate,
            selectedDate: _selectedDate,
            currentDate: widget.currentDate,
            maxDate: widget.maxDate,
            minDate: widget.minDate,
            currentDateDecoration: widget.currentDateDecoration,
            currentDateTextStyle: widget.currentDateTextStyle,
            disbaledCellsDecoration: widget.disbaledCellsDecoration,
            disbaledCellsTextStyle: widget.disbaledCellsTextStyle,
            enabledCellsDecoration: widget.enabledCellsDecoration,
            enabledCellsTextStyle: widget.enabledCellsTextStyle,
            selectedCellDecoration: widget.selectedCellDecoration,
            selectedCellTextStyle: widget.selectedCellTextStyle,
            slidersColor: widget.slidersColor,
            slidersSize: widget.slidersSize,
            leadingDateTextStyle: widget.leadingDateTextStyle,
            splashColor: widget.splashColor,
            highlightColor: widget.highlightColor,
            splashRadius: widget.splashRadius,
            onLeadingDateTap: () {
              setState(() {
                _pickerType = PickerType.years;
              });
            },
            onDateSelected: (selectedMonth) {
              setState(() {
                _displayedDate = selectedMonth;
                _pickerType = PickerType.days;
              });
            },
          ),
        );
      case PickerType.years:
        return Padding(
          padding: widget.padding,
          child: YearsPicker(
            initialDate: _displayedDate,
            selectedDate: _selectedDate,
            currentDate: widget.currentDate,
            maxDate: widget.maxDate,
            minDate: widget.minDate,
            currentDateDecoration: widget.currentDateDecoration,
            currentDateTextStyle: widget.currentDateTextStyle,
            disbaledCellsDecoration: widget.disbaledCellsDecoration,
            disbaledCellsTextStyle: widget.disbaledCellsTextStyle,
            enabledCellsDecoration: widget.enabledCellsDecoration,
            enabledCellsTextStyle: widget.enabledCellsTextStyle,
            selectedCellDecoration: widget.selectedCellDecoration,
            selectedCellTextStyle: widget.selectedCellTextStyle,
            slidersColor: widget.slidersColor,
            slidersSize: widget.slidersSize,
            leadingDateTextStyle: widget.leadingDateTextStyle,
            splashColor: widget.splashColor,
            highlightColor: widget.highlightColor,
            splashRadius: widget.splashRadius,
            onDateSelected: (selectedYear) {
              setState(() {
                _displayedDate = selectedYear;
                _pickerType = PickerType.months;
              });
            },
          ),
        );
    }
  }
}
