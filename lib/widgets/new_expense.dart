import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
// import 'package:intl/intl.dart';

// final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  void _presentDatePicker() async
  {
    //final now = DateTime.now();
    final firstDate = DateTime(2023);
    //final lastDate = DateTime(2025);
    final pickedDate = await showDatePicker(
      context: context, 
      firstDate: firstDate, 
      lastDate: DateTime.now()
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  // var _enteredTitle = '';
  // void _saveTitleInput(String inputValue){
  //   _enteredTitle = inputValue;
  // }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            //onChanged: _saveTitleInput,
            maxLength: 50,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  //onChanged: _saveTitleInput,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefix: Text('\$ '),
                    labelText: 'Amount',
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(_selectedDate == null ? 'No date selected!' : formatter.format(_selectedDate!)),
                    IconButton(onPressed:_presentDatePicker, 
                      icon: const Icon(Icons.calendar_month)
                    ),
                  ],
                ),
              )

            ],
          ),
          Row(
            children: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, 
                child: const Text('Cancell'),
              ),
              ElevatedButton(onPressed: ()
                {
                  print(_titleController.text);
                  print(_amountController.text);
                }, 
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}