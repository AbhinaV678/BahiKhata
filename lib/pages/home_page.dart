import 'package:e_khata/components/expenses_summary.dart';
import 'package:e_khata/components/expenses_tile.dart';
import 'package:e_khata/data/expense_data.dart';
import 'package:e_khata/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseRupeeController = TextEditingController();
  final newExpensePaiseController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //Prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: Text("Add new expense"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: newExpenseNameController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(hintText: "Expense name"),
                  ),
                  Row(
                    children: [
                      //Rupees
                      Expanded(
                        child: TextField(
                          controller: newExpenseRupeeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: "Rupees"),
                        ),
                      ),
                      const Spacer(),
                      //paise
                      Expanded(
                        child: TextField(
                          controller: newExpensePaiseController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: "Paise"),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: const Text("Save"),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: const Text("Cancel"),
                )
              ],
            )));
  }

//deleting expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  void save() {
    //Null safety
    if (newExpenseNameController.text.isNotEmpty &&
        newExpenseRupeeController.text.isNotEmpty &&
        newExpensePaiseController.text.isNotEmpty) {
      //Putting both ruppee and paise together
      String amount =
          "${newExpenseRupeeController.text}.${newExpensePaiseController.text}";
      ExpenseItem newExpense = ExpenseItem(
          name: newExpenseNameController.text,
          amount: amount,
          dateTime: DateTime.now());

      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    //method to clear the controller
    newExpenseNameController.clear();
    newExpenseRupeeController.clear();
    newExpensePaiseController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: ((context, value, child) => Scaffold(
          backgroundColor: Colors.blueGrey[100],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
          ),
          body: ListView(
            children: [
              ExpenseSummary(startOfWeek: value.startOfweekDate()),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getAllExpenseList().length,
                  itemBuilder: ((context, index) => ExpenseTile(
                        name: value.getAllExpenseList()[index].name,
                        amount: value.getAllExpenseList()[index].amount,
                        dateTime: value.getAllExpenseList()[index].dateTime,
                        deleteTapped: ((p0) =>
                            deleteExpense(value.getAllExpenseList()[index])),
                      ))),
            ],
          ))),
    );
  }
}
