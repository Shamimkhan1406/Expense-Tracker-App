
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
// import 'package:intl/intl.dart';

// final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense(this.onAddExpense,{super.key});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.leisure;
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
  void _showDialog()
  {
    if(Platform.isIOS)
    {
      showCupertinoDialog(context: context, builder: (ctx)
      {
        return CupertinoAlertDialog(
          title: const Text('Invalid Input'),
          content: const Text("plese make sure valid title,amount,date was entered!"),
          actions: [
            TextButton(onPressed: ()
            {
              Navigator.pop(ctx);
              //Navigator.of(ctx).pop();
            }, 
            child: const Text('Okey'),
            ),
          ],
        );
      }
      );
    }
    else{
      showDialog(context: context, builder: (ctx)
      {
        return AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text("plese make sure valid title,amount,date was entered!"),
          actions: [
            TextButton(onPressed: ()
            {
              Navigator.pop(ctx);
              //Navigator.of(ctx).pop();
            }, 
            child: const Text('Okey'),
            ),
          ],
        );
      });
    }
    
      
  }
  void _submitExpenseData()
  {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountInvalid = enteredAmount == null || enteredAmount <= 0;
    if(_titleController.text.trim().isEmpty || amountInvalid || _selectedDate == null)
    {
      //show error massege;
      _showDialog();
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text, 
        amount: enteredAmount, 
        date: _selectedDate!, 
        category: _selectedCategory
      ),
    );
    Navigator.pop(context);
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
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: ((context, constraints) {
      // print(constraints.minWidth);
      // print(constraints.maxWidth);
      // print(constraints.minHeight);
      // print(constraints.maxHeight);
      final  width = constraints.maxWidth;
    
      return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 60, 20, keyboardSpace+20),
        child: Column(

          children: [
            if (width>=600)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                    controller: _titleController,
                    //onChanged: _saveTitleInput,
                    maxLength: 50,
                    decoration: const InputDecoration(
                    labelText: 'Title',
                                    ),
                                  ),
                  ),
              const SizedBox(width: 16,),
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

              ],
              )
            else
            TextField(
              controller: _titleController,
              //onChanged: _saveTitleInput,
              maxLength: 50,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            if(width >= 600)
            Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: Category.values.map((e)
                  {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e.name.toUpperCase())
                    );
                  }).toList(), 
                  onChanged: (value){
                    setState(() {
                      _selectedCategory = value as Category;
                      //->->
                    });
                    //print(value);
                  }
                ),
                const SizedBox(width: 16,),
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
            )
            else
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
                const SizedBox(width: 20,),
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
            const SizedBox(height: 20,),
            if(width>=600)
            Row(
              children: [
                const Spacer(),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, 
                  child: const Text('Cancel'),
                ),
                ElevatedButton(onPressed: _submitExpenseData,
                  child: const Text('Save Expense'),
                ),
              ],
            )
            else
            Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: Category.values.map((e)
                  {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e.name.toUpperCase())
                    );
                  }).toList(), 
                  onChanged: (value){
                    setState(() {
                      _selectedCategory = value as Category;
                      //->->
                    });
                    //print(value);
                  }
                ),
                const Spacer(),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, 
                  child: const Text('Cancel'),
                ),
                ElevatedButton(onPressed: _submitExpenseData,
                  child: const Text('Save Expense'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    }
    ));
    
  }
}