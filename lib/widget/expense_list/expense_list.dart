import 'package:expense_tracker/widget/expense_list/expense_item.dart';
import 'package:expense_tracker/modals/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expeense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, idx) => Dismissible(
          key: ValueKey(expenses[idx]),
          background: Container(
            margin: Theme.of(context).cardTheme.margin!,
            color:
                Theme.of(context).colorScheme.onErrorContainer.withOpacity(0.6),
            child: Icon(Icons.delete,
                color: Theme.of(context).colorScheme.primaryContainer),
          ),
          onDismissed: (direction) {
            onRemoveExpense(expenses[idx]);
          },
          child: ExpenseItem(
            expense: expenses[idx],
          ),
        ),
      ),
    );
  }
}
