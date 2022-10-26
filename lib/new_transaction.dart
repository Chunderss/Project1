import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'expense_class.dart';
import 'main.dart';
import 'list_of_expenses.dart';

class NewTransaction extends StatefulWidget {
  @override
  State<NewTransaction> createState() => NewTransactionState();
}

class NewTransactionState extends State<NewTransaction> {
  final _formKey = GlobalKey<FormState>();
  String selectedValue = myExpenseKeys[0];
  late double myAmount;
  late String myCat;
  late String theExpense = '';
  late List<DropdownMenuItem<String>> dropdownItemsExpense = [];
  late TextEditingController myController;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> myItems = [];
    for (int i = 0; i < myExpenseKeys.length; i++) {
      myItems.add(DropdownMenuItem(
          value: myExpenseKeys[i], child: Text(myExpenseKeys[i])));
    }
    return myItems;
  }

  void updateExpenseList() {
    setState(() {
      dropdownItemsExpense.clear();
      for(int i = 0; i < myExpense.myExpenses[selectedValue]!.length; i++){
        dropdownItemsExpense.add(
          DropdownMenuItem(value: myExpense.myExpenses[selectedValue]![i], child: Text(myExpense.myExpenses[selectedValue]![i])),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      updateExpenseList();
      myController = TextEditingController();
    });
  }

  void saveTransaction() {
    setState(() {
      if (_formKey.currentState!.validate()) {
        myExpense.addNewDailyExpense(selectedValue, theExpense, myAmount);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('New Transaction'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: TextFormField(
                          controller: myController,
                            decoration: InputDecoration(
                              hintText: 'Currency',
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.blue, width: 8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onTap: () {
                              showCurrencyPicker(
                                context: context,
                                onSelect: (Currency currency) {
                                  myController.text = currency.symbol;
                                },
                              );
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please choose a valid value';
                              }
                              return null;
                            }),
                      ),
                      SizedBox(
                        width: 200,
                        height: 100,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Amount',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty || value.runtimeType != double) {
                              return 'Please enter a valid value';
                            }
                            return null;
                          },
                          onChanged: (value) =>
                              setState(() => myAmount = double.parse(value)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                width: 200,
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Category',
                  ),
                  value: selectedValue,
                  items: dropdownItems,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                      updateExpenseList();
                    });
                  },
                ),
              ),
              SizedBox(
                height: 100,
                width: 200,
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Expense',
                  ),
                  value: dropdownItemsExpense[0].value,
                  items: dropdownItemsExpense,
                  onChanged: (value) => setState(() => theExpense = value!),
                ),
              ),
              ElevatedButton(
                onPressed: () => saveTransaction(),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
