import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expenses,this.onRemovedExpense,{super.key});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemovedExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: ((context, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.25),
          ),
          key: ValueKey(expenses[index]),
          onDismissed: (direction)
          {
            onRemovedExpense(expenses[index]);
          },
          child: ExpenseItem(expenses[index]),
        )
      ),
    );
  }
}