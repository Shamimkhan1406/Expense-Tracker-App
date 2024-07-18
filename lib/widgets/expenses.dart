import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(title: 'Flutter Course', amount: 19.19, date: DateTime.now(), category: Category.work),
    Expense(title: 'Lunch', amount: 4.99, date: DateTime.now(),category: Category.food),
  ];
  void _openAddExpenseOverlay()
  {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (ctx){
      return NewExpense(_addExpense);
    });
  }
  void _addExpense(Expense expense)
  {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }
  void _removeExpenses(Expense expense)
  {
    _registeredExpenses.remove(expense);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense tracker'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(child: ExpensesList(_registeredExpenses,_removeExpenses)),
        ],
      ),
    );
  }
}