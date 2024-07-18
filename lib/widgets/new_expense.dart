import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
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
          TextField(
            controller: _amountController,
            //onChanged: _saveTitleInput,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefix: Text('\$ '),
              labelText: 'Amount',
            ),
          ),
          Row(
            children: [
              TextButton(onPressed: (){}, 
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