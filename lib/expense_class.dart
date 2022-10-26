import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';


class Expense {
  late Map<String,Map<String,double>> myCurrExpense = {};
  Map<DateTime, Map<String,Map<String,double>>> pastExpenses = {};
  Map<String, List<String>> myExpenses = {
    'Entertainment': ['Movie','Escape Room'],
    'Food': ['Starbucks','Mcdonalds'],
    'Necessities': ['Gas','Rent','Groceries'],
    'Travel': ['Hawaii','Up North'],
  };

  void initCurrExpense() {
    List<String> myExpenseKeys = myExpenses.keys.toList();
    for(int i = 0; i < myExpenseKeys.length; i++) {
      myCurrExpense[myExpenseKeys[i]] = {};
    }
  }

  void newDay() {
    DateTime now = DateTime.now();
    DateTime currDate = DateTime(now.year,now.month,now.day);

    pastExpenses[currDate] = {};
    //Need to make copy of myCurrExpense
    pastExpenses[currDate] = {...myCurrExpense};
    myCurrExpense.clear();
  }

   myDateReturn(DateTime myDate) {
    late Map<String,Map<String,double>> myMap = {};
    DateTime myModifiedDate = DateTime(myDate.year,myDate.month,myDate.day);

    if (pastExpenses[myModifiedDate] == null){
      return myMap;
    } else {
      myMap = pastExpenses[myModifiedDate]!;
      return myMap;
    }
  }

  DateTime myPastDateReturn(int daysAgo, DateTime myDate) {
    DateTime myModifiedDate = DateTime(myDate.year,myDate.month,(myDate.day - daysAgo));
    return myModifiedDate;
  }

  void addNewDailyExpense(String myCat, String theExpense, double totalSpent) {
    List<String> myCurrExpenseKeys = myCurrExpense.keys.toList();
    if (myCurrExpenseKeys.contains(myCat)){
      myCurrExpense[myCat]![theExpense] = totalSpent;
    } else {
      myCurrExpense[myCat] = {};
      myCurrExpense[myCat]![theExpense] = totalSpent;
    }
  }

  getCurrExpenseMap(){
    List<String> myCurrExpenseKeys = myCurrExpense.keys.toList();
    List<String> myMainExpenseKeys = [];
    Map<String,double> myMainExpenses = {};

    if (myCurrExpense.isEmpty || myCurrExpenseKeys.isEmpty){
      return myMainExpenses;
    } else {
      // Fix this (probably something to do with addAll)
      for (int i = 0; i < myCurrExpenseKeys.length; i++) {
        myMainExpenseKeys.addAll(myCurrExpense[myCurrExpenseKeys[i]]!.keys);
      }

      for (int i = 0; i < myMainExpenseKeys.length; i ++) {
        myMainExpenses[myMainExpenseKeys[i]] = myCurrExpense[myCurrExpenseKeys[i]]![myMainExpenseKeys[i]]!;
      }

      return myMainExpenses;
    }
  }

  getPastExpenseMap(Map<String,Map<String,double>> myMap) {
    List<String> myMapExpenseKeys = myMap.keys.toList();
    List<String> myMainExpenseKeys = [];
    Map<String,double> myMainExpenses = {};


    for(int i = 0; i < myMapExpenseKeys.length; i++) {
      myMainExpenseKeys.addAll(myMap[myMapExpenseKeys[i]]!.keys);
    }

    for(int i =0; i < myMainExpenseKeys.length; i ++){
      myMainExpenses[myMainExpenseKeys[i]] = myMap[myMapExpenseKeys[i]]![myMainExpenseKeys[i]]!;
    }

    return myMainExpenses;
  }


}