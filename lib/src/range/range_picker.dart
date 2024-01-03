import 'package:flutter/material.dart';

import '../shared/month_picker.dart';
import '../shared/picker_type.dart';
import '../shared/year_picker.dart';
import 'range_days_picker.dart';

class RangeDatePicker extends StatefulWidget {
  RangeDatePicker({
    super.key,
    required this.maxDate,
    required this.minDate,
    this.onRangeSelected,
    this.currentDate,
    this.initialDate,
    this.selectedRange,
    this.padding = const EdgeInsets.all(16),
    this.initialPickerType = PickerType.days,
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
    this.leadingDateTextStyle,
    this.slidersColor,
    this.slidersSize,
    this.highlightColor,
    this.splashColor,
    this.splashRadius,
    this.applyButtonTextStyle,
    this.applyButtonBoxDecoration,
    this.cancelButtonTextStyle,
    this.cancelButtonBoxDecoration,
    this.twoButtonCenterSpace,
    this.calcelButtonText,
    this.okButtonText,
    this.applyButtonColor,
    this.cancelButtonColor,
  }) {
    assert(
      !maxDate.isBefore(minDate),
      'maxDate $maxDate must be on or after minDate $minDate.',
    );
  }

  final DateTimeRange? selectedRange;
  final DateTime? currentDate;
  final DateTime? initialDate;
  final ValueChanged<DateTimeRange>? onRangeSelected;
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

  @override
  State<RangeDatePicker> createState() => _RangeDatePickerState();
}

class _RangeDatePickerState extends State<RangeDatePicker> {
  PickerType? _pickerType;
  DateTime? _diplayedDate;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  @override
  void initState() {
    _pickerType = widget.initialPickerType;
    _diplayedDate = widget.initialDate ?? DateUtils.dateOnly(DateTime.now());
    if (widget.selectedRange != null) {
      _selectedStartDate = widget.selectedRange!.start;
      _selectedEndDate = widget.selectedRange!.end;
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant RangeDatePicker oldWidget) {
    if (oldWidget.initialPickerType != widget.initialPickerType) {
      _pickerType = widget.initialPickerType;
    }

    if (widget.selectedRange != oldWidget.selectedRange) {
      _selectedStartDate = widget.selectedRange?.start;
      _selectedEndDate = widget.selectedRange?.end;
    }

    if (widget.initialDate != oldWidget.initialDate) {
      _diplayedDate = widget.initialDate ?? DateUtils.dateOnly(DateTime.now());
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    switch (_pickerType!) {
      case PickerType.days:
        return Padding(
          padding: widget.padding,
          child: RangeDaysPicker(
            applyButtonTextStyle: widget.applyButtonTextStyle,
            applyButtonBoxDecoration: widget.applyButtonBoxDecoration,
            cancelButtonTextStyle: widget.cancelButtonTextStyle,
            cancelButtonBoxDecoration: widget.cancelButtonBoxDecoration,
            twoButtonCenterSpace: widget.twoButtonCenterSpace,
            calcelButtonText: widget.calcelButtonText,
            okButtonText: widget.okButtonText,
            applyButtonColor: widget.applyButtonColor,
            cancelButtonColor: widget.cancelButtonColor,
            currentDate: widget.currentDate ?? DateUtils.dateOnly(DateTime.now()),
            initialDate: _diplayedDate!,
            selectedEndDate: _selectedEndDate,
            selectedStartDate: _selectedStartDate,
            maxDate: widget.maxDate,
            minDate: widget.minDate,
            daysOfTheWeekTextStyle: widget.daysOfTheWeekTextStyle,
            enabledCellsTextStyle: widget.enabledCellsTextStyle,
            enabledCellsDecoration: widget.enabledCellsDecoration,
            disbaledCellsTextStyle: widget.disbaledCellsTextStyle,
            disbaledCellsDecoration: widget.disbaledCellsDecoration,
            currentDateDecoration: widget.currentDateDecoration,
            currentDateTextStyle: widget.currentDateTextStyle,
            selectedCellsDecoration: widget.selectedCellsDecoration,
            selectedCellsTextStyle: widget.selectedCellsTextStyle,
            singelSelectedCellTextStyle: widget.singelSelectedCellTextStyle,
            singelSelectedCellDecoration: widget.singelSelectedCellDecoration,
            slidersColor: widget.slidersColor,
            slidersSize: widget.slidersSize,
            leadingDateTextStyle: widget.leadingDateTextStyle,
            splashColor: widget.splashColor,
            highlightColor: widget.highlightColor,
            splashRadius: widget.splashRadius,
            onRangeSelected: widget.onRangeSelected,
            onLeadingDateTap: () {
              setState(() {
                _pickerType = PickerType.months;
              });
            },
            onEndDateChanged: (date) {
              setState(() {
                _selectedEndDate = date;
                endingDate = date;
              });
              if (_selectedStartDate != null) {
                // widget.onRangeSelected?.call(DateTimeRange(start: _selectedStartDate!, end: _selectedEndDate!));
              }
            },
            onStartDateChanged: (date) {
              setState(() {
                _selectedStartDate = date;
                startingDate = date;
                _selectedEndDate = null;
              });
            },
          ),
        );
      case PickerType.months:
        return Padding(
          padding: widget.padding,
          child: MonthPicker(
            initialDate: _diplayedDate,
            selectedDate: null,
            maxDate: widget.maxDate,
            minDate: widget.minDate,
            currentDate: widget.currentDate,
            currentDateDecoration: widget.currentDateDecoration,
            currentDateTextStyle: widget.currentDateTextStyle,
            disbaledCellsDecoration: widget.disbaledCellsDecoration,
            disbaledCellsTextStyle: widget.disbaledCellsTextStyle,
            enabledCellsDecoration: widget.enabledCellsDecoration,
            enabledCellsTextStyle: widget.enabledCellsTextStyle,
            selectedCellDecoration: widget.singelSelectedCellDecoration,
            selectedCellTextStyle: widget.singelSelectedCellTextStyle,
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
                _diplayedDate = selectedMonth;
                _pickerType = PickerType.days;
              });
            },
          ),
        );
      case PickerType.years:
        return Padding(
          padding: widget.padding,
          child: YearsPicker(
            selectedDate: null,
            initialDate: _diplayedDate,
            maxDate: widget.maxDate,
            minDate: widget.minDate,
            currentDate: widget.currentDate,
            currentDateDecoration: widget.currentDateDecoration,
            currentDateTextStyle: widget.currentDateTextStyle,
            disbaledCellsDecoration: widget.disbaledCellsDecoration,
            disbaledCellsTextStyle: widget.disbaledCellsTextStyle,
            enabledCellsDecoration: widget.enabledCellsDecoration,
            enabledCellsTextStyle: widget.enabledCellsTextStyle,
            selectedCellDecoration: widget.singelSelectedCellDecoration,
            selectedCellTextStyle: widget.singelSelectedCellTextStyle,
            slidersColor: widget.slidersColor,
            slidersSize: widget.slidersSize,
            leadingDateTextStyle: widget.leadingDateTextStyle,
            splashColor: widget.splashColor,
            highlightColor: widget.highlightColor,
            splashRadius: widget.splashRadius,
            onDateSelected: (selectedYear) {
              setState(() {
                _diplayedDate = selectedYear;
                _pickerType = PickerType.months;
              });
            },
          ),
        );
    }
  }
}

DateTime? startingDate;
DateTime? endingDate;
