import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction(this.addTx, {Key? key}) : super(key: key);

  final Function(String, double, DateTime) addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  double truncateToDecimalPlaces(num value, int fractionalDigits) =>
      (value * pow(10, fractionalDigits)).truncate() /
      pow(10, fractionalDigits);

  void _submitData() {
    final titleText = _titleController.text;
    final parsedAmount = double.tryParse(_amountController.text) == null
        ? 0.0
        : double.parse(_amountController.text);

    if (titleText.isEmpty || parsedAmount <= 0) {
      return;
    }

    widget.addTx(
      titleText,
      truncateToDecimalPlaces(parsedAmount, 2),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((choosenDate) {
      if (choosenDate == null) return;
      setState(() {
        _selectedDate = choosenDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title'),
            controller: _titleController,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Amount'),
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitData(),
          ),
          SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date: ${DateFormat.yMd().format(_selectedDate)}'),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: const Text(
                    'Change date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _submitData,
            child: const Text(
              'Add Transaction',
            ),
          )
        ],
      ),
    );
  }
}
