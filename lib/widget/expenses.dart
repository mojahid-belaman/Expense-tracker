import 'package:flutter/material.dart';

import 'package:expense_tracker/modals/expense.dart';
import 'package:expense_tracker/widget/expense_list/expense_list.dart';
import 'package:expense_tracker/widget/new_expense.dart';

import 'package:expense_tracker/widget/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expenses> {
  final List<Expense> registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 11.10,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.90,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(addNewExpense),
    );
  }

  void addNewExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final indexExpensse = registeredExpenses.indexOf(expense);
    setState(() {
      registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense removed!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            registeredExpenses.insert(indexExpensse, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Expenses Found. Start Adding Some!'),
    );
    if (registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
          expenses: registeredExpenses, onRemoveExpense: removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openModal,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: registeredExpenses),
          mainContent,
        ],
      ),
    );
  }
}
