import 'package:flutter/material.dart';
import '../widgets/chart_bar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  const Chart({super.key, required this.recentTransactions});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1).toString(),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, nextItem) {
      return sum + (nextItem['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(14.0),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((transaction) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: transaction['day'] as String,
                  spendingAmount: transaction['amount'] as double,
                  spendingPercentage: totalSpending == 0.0
                      ? 0.0
                      : (transaction['amount'] as double) / totalSpending,
                ),
              );
            }).toList()),
      ),
    );
  }
}
