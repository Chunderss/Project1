import 'package:flutter/material.dart';
import 'new_transaction.dart';
import 'package:pie_chart/pie_chart.dart';
import 'list_of_expenses.dart';
import 'expense_class.dart';

Expense myExpense = Expense();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyListOfExpenses(),
    );
  }
}

class MyHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyListOfExpenses()));
          },
        ),
      ),
    );
  }
}