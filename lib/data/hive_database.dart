import 'package:e_khata/models/expense_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataBase {
  final _myBox = Hive.box("My_database");

  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

//Data stored in Hive as alist of strings and datetime dataTypes
  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ??
        []; // if list is empty or null return empty list
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      //i is used to access a particular list of index i
      //0,1,2 are used to access the items in that List i.e name,amount,dateTime
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItem expense =
          ExpenseItem(name: name, amount: amount, dateTime: dateTime);

      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
