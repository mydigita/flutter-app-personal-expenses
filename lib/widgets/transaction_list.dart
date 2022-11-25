import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTxn;
  const TransactionList(
      {super.key, required this.transactions, required this.deleteTxn});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          elevation: 5,
          margin: const EdgeInsets.only(top: 6),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox(
                  child: Text(
                    '\$${transactions[index].amount.toStringAsFixed(1)}',
                  ),
                ),
              ),
            ),
            title: Text(
              transactions[index].title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Text(
              DateFormat('dd-MM-yyyy').format(transactions[index].date),
            ),
            trailing: IconButton(
              onPressed: () => deleteTxn(transactions[index].id),
              icon: const Icon(Icons.delete),
            ),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}
