import 'package:flutter/material.dart';
import 'expense_class.dart';
import 'main.dart';
import 'new_transaction.dart';

List<String> myExpenseKeys = myExpense.myExpenses.keys.toList();

class MyListOfExpenses extends StatefulWidget {
  @override
  State<MyListOfExpenses> createState() => MyListOfExpensesState();
}

class MyListOfExpensesState extends State<MyListOfExpenses> {

  Map<String,double>  myCurrExpenseMap = myExpense.getCurrExpenseMap();
  late List<String> myCurrExpenseMapKeys = myCurrExpenseMap.keys.toList();
  DateTime current = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {
      myCurrExpenseMap;
      myCurrExpenseMapKeys;
    });
  }

  void myRefresh() {
    setState(() {
      myCurrExpenseMap = myExpense.getCurrExpenseMap();
      myCurrExpenseMapKeys = myCurrExpenseMap.keys.toList();
    });
    return;
  }

  void myDelayedRefresh(value) async {
    setState(() {
      myCurrExpenseMap = myExpense.getCurrExpenseMap();
      myCurrExpenseMapKeys = myCurrExpenseMap.keys.toList();
    });
    return;
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Expenses'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewTransaction())).then(myDelayedRefresh);
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text('Today'),
            ),
            Expanded(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: myCurrExpenseMap.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading: const Icon(Icons.circle_rounded),
                          trailing: Text('${myCurrExpenseMap[myCurrExpenseMapKeys[index]]}'),
                          title: Center(
                            child: Text('${myCurrExpenseMapKeys[index]}'),
                          ));
                    }),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(10),
              child: const Text('Yesterday'),
            ),
            Expanded(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                    itemCount: myExpense.getPastExpenseMap(myExpense.myDateReturn(myExpense.myPastDateReturn(0, current))).length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          leading: const Icon(Icons.circle_rounded),
                          trailing: Text('${(myExpense.getPastExpenseMap(myExpense.myDateReturn(myExpense.myPastDateReturn(0, current))))[(myExpense.getPastExpenseMap(myExpense.myDateReturn(myExpense.myPastDateReturn(0, current))).keys.toList())[index]]}'),
                          title: Center(
                            child: Text('${(myExpense.getPastExpenseMap(myExpense.myDateReturn(myExpense.myPastDateReturn(0, current))).keys.toList())[index]}'),
                          ));
                    }),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                myExpense.newDay();
                myRefresh();
              },
              child: const Text('Test'),
            ),
          ],
        ),
      ),
    );
  }
}
