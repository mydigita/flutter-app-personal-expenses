import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function txnDetails;
  const NewTransaction({super.key, required this.txnDetails});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    // .trim() will remove leading whitespace if any

    final enteredTitle = _titleController.text.trim();
    double? enteredAmount = 0;

    // before applying double.parse(), first check if it really has numbers
    // then remove everything from the string but keep only numbers and a dot
    if (_amountController.text.contains(RegExp('[1-9]'))) {
      enteredAmount = double.parse(
          _amountController.text.trim().replaceAll(RegExp('[^0-9.]'), ''));
    }

    if (!_titleController.text.contains(RegExp('[a-zA-Z0-9]')) ||
        _amountController.text.isEmpty ||
        enteredAmount <= 0 ||
        _amountController.text.contains(RegExp('[a-zA-Z,]')) ||
        _selectedDate == null) {
      return;
    }

    widget.txnDetails(
      enteredTitle,
      enteredAmount,
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
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: null,
      child: SingleChildScrollView(
        child: Card(
          elevation: 5,
          child: Container(
            color: null,
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                ),
                Container(
                  height: 70.0,
                  color: null,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(_selectedDate == null
                            ? 'No date selected.'
                            : "Txn date: ${DateFormat('dd-MM-yyyy').format(_selectedDate!).toString()}"),
                      ),
                      OutlinedButton(
                        onPressed: _presentDatePicker,
                        child: const Text('Select Date'),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style:
                          OutlinedButton.styleFrom(shape: const CircleBorder()),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_downward_rounded),
                    ),
                    ElevatedButton(
                      onPressed: _submitData,
                      child: const Text('Add Transaction'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
