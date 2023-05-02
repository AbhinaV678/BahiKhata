import 'package:e_khata/bar%20graph/bar_graph.dart';
import 'package:e_khata/data/expense_data.dart';
import 'package:e_khata/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({super.key, required this.startOfWeek});

  double calculatedMax(
    //function for keeping the bar graph within screen
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyexpenseSummary()[sunday] ?? 0,
      value.calculateDailyexpenseSummary()[monday] ?? 0,
      value.calculateDailyexpenseSummary()[tuesday] ?? 0,
      value.calculateDailyexpenseSummary()[wednesday] ?? 0,
      value.calculateDailyexpenseSummary()[thursday] ?? 0,
      value.calculateDailyexpenseSummary()[friday] ?? 0,
      value.calculateDailyexpenseSummary()[saturday] ?? 0,
    ];
//sorting from smallest to largest
    values.sort();
    max = values.last *
        1.1; //The values of the last i.e greatest will always be alloted a space just slightly bigger so that it fits within screen

    return max == 0 ? 100 : max;
  }

  String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values = [
      value.calculateDailyexpenseSummary()[sunday] ?? 0,
      value.calculateDailyexpenseSummary()[monday] ?? 0,
      value.calculateDailyexpenseSummary()[tuesday] ?? 0,
      value.calculateDailyexpenseSummary()[wednesday] ?? 0,
      value.calculateDailyexpenseSummary()[thursday] ?? 0,
      value.calculateDailyexpenseSummary()[friday] ?? 0,
      value.calculateDailyexpenseSummary()[saturday] ?? 0,
    ];
    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total = total + values[i];
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    String sunday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
        builder: ((context, value, child) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      const Text(
                        "Week Total:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " \₹${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: MyBarGraph(
                      maxY: calculatedMax(value, sunday, monday, tuesday,
                          wednesday, thursday, friday, saturday),
                      sunAmount: value.calculateDailyexpenseSummary()[sunday] ??
                          0, //if no expenses entered display 0
                      monAmount:
                          value.calculateDailyexpenseSummary()[monday] ?? 0,
                      tueAmount:
                          value.calculateDailyexpenseSummary()[tuesday] ?? 0,
                      wedAmount:
                          value.calculateDailyexpenseSummary()[wednesday] ?? 0,
                      thurAmount:
                          value.calculateDailyexpenseSummary()[thursday] ?? 0,
                      friAmount:
                          value.calculateDailyexpenseSummary()[friday] ?? 0,
                      satAmount:
                          value.calculateDailyexpenseSummary()[saturday] ?? 0),
                ),
              ],
            )));
  }
}
