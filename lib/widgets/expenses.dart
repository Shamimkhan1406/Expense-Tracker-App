
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
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: (){
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    Widget _mainContent = const Center(
        child: Text('No expense found.Start adding some!')
      );
      if(_registeredExpenses.isNotEmpty)
      {
        _mainContent = ExpensesList(_registeredExpenses, _removeExpenses);
      }
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
          Expanded(child: _mainContent),
        ],
      ),
    );
  }
}