import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../models/grouped_transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransactions, {Key? key}) : super(key: key);

  final List<Transaction> recentTransactions;

  List<GroupedTransaction> get groupedTransactionsValue {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        var totalSum = 0.0;

        for (var tx in recentTransactions) {
          if (tx.date.day == weekDay.day) {
            totalSum += tx.amount;
          }
        }

        return GroupedTransaction(
          day: DateFormat.E().format(weekDay).substring(0, 1),
          amount: totalSum,
        );
      },
    ).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionsValue.fold(
      0.0,
      (previousValue, element) => previousValue += element.amount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...groupedTransactionsValue.map(
              (data) => Expanded(
                child: ChartBar(
                  data.day,
                  data.amount,
                  data.amount > 0 ? data.amount / maxSpending : 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
