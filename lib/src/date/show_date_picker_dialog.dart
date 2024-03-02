import 'package:flutter/material.dart';

import '../shared/picker_type.dart';
import 'date_picker.dart';

Future<DateTime?> showDatePickerDialog({
  required BuildContext context,
  required DateTime maxDate,
  required DateTime minDate,
  DateTime? initialDate,
  DateTime? currentDate,
  DateTime? selectedDate,
  EdgeInsets contentPadding = const EdgeInsets.all(16),
  EdgeInsets padding = const EdgeInsets.all(36),
  PickerType initialPickerType = PickerType.days,
  bool barrierDismissible = true,
  Color? barrierColor = Colors.black54,
  String? barrierLabel,
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  TextStyle? daysOfTheWeekTextStyle,
  TextStyle? enabledCellsTextStyle,
  BoxDecoration enabledCellsDecoration = const BoxDecoration(),
  TextStyle? disbaledCellsTextStyle,
  BoxDecoration disbaledCellsDecoration = const BoxDecoration(),
  TextStyle? currentDateTextStyle,
  BoxDecoration? currentDateDecoration,
  TextStyle? selectedCellTextStyle,
  BoxDecoration? selectedCellDecoration,
  double? slidersSize,
  Color? slidersColor,
  TextStyle? leadingDateTextStyle,
  Color? highlightColor,
  Color? splashColor,
  double? splashRadius,
  Color? backgroundColor,
  Color? themeColor,
  double? borderRadius,
}) async {
  return showDialog(
    context: context,
    barrierColor: barrierColor,
    anchorPoint: anchorPoint,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    routeSettings: routeSettings,
    useRootNavigator: useRootNavigator,
    useSafeArea: useSafeArea,
    builder: (context) {
      return Padding(
        padding: padding,
        child: Dialog(
          backgroundColor: backgroundColor ?? Colors.white,
          surfaceTintColor: backgroundColor ?? Colors.white,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10))),
          child: DatePicker(
            initialDate: initialDate,
            maxDate: maxDate,
            minDate: minDate,
            currentDate: currentDate,
            selectedDate: selectedDate,
            onDateSelected: (value) => Navigator.pop(context, value),
            initialPickerType: initialPickerType,
            padding: contentPadding,
            currentDateDecoration: currentDateDecoration,
            currentDateTextStyle: currentDateTextStyle,
            disbaledCellsDecoration: disbaledCellsDecoration,
            disbaledCellsTextStyle: disbaledCellsTextStyle,
            enabledCellsDecoration: enabledCellsDecoration,
            enabledCellsTextStyle: enabledCellsTextStyle,
            selectedCellDecoration: selectedCellDecoration,
            selectedCellTextStyle: selectedCellTextStyle,
            daysOfTheWeekTextStyle: daysOfTheWeekTextStyle,
            leadingDateTextStyle: leadingDateTextStyle,
            slidersColor: slidersColor,
            slidersSize: slidersSize,
            highlightColor: highlightColor,
            splashColor: splashColor,
            splashRadius: splashRadius,
            themeColor: themeColor,
          ),
        ),
      );
    },
  );
}
