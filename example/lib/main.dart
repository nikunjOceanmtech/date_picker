import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en', 'US'),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en', 'GB'),
        Locale('en', 'US'),
        Locale('ar'),
        Locale('zh'),
      ],
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // RangeDatePicker(
                  //   daysOfTheWeekTextStyle: TextStyle(
                  //     color: Colors.green,
                  //   ),
                  //   // onRangeSelected: (Date) {
                  //   //   print(Date);
                  //   // },
                  //   currentDateDecoration: BoxDecoration(
                  //     border: Border.all(),
                  //     shape: BoxShape.circle,
                  //   ),
                  //   minDate: DateTime(2020, 10, 10),
                  //   maxDate: DateTime(2024, 10, 30),
                  // ),
                  // DatePicker(
                  //   minDate: DateTime(1000),
                  //   maxDate: DateTime(2025),
                  // ),
                  ElevatedButton(
                    onPressed: () async {
                      DateTimeRange? dates = await showRangePickerDialog(
                        maxDate: DateTime(2025),
                        context: context,
                        minDate: DateTime(2000),
                      );
                      if (dates != null) {
                        print(dates);
                      }
                    },
                    child: const Text("Range Picker Dialog  "),
                  ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     showDatePickerDialog(
                  //       maxDate: DateTime(2025),
                  //       context: context,
                  //       minDate: DateTime(2000),
                  //     );
                  //     // print(date);
                  //   },
                  //   child: const Text("Range Picker Dialog  "),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
