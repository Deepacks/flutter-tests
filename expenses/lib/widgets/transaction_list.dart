import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.deleteTx, {Key? key})
      : super(key: key);

  final List<Transaction> transactions;
  final Function(String) deleteTx;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) => Column(
              children: [
                Text(
                  'No transactions added yet.',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.3,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          )
        : ListView(
            children: [
              ...transactions.map((tx) => TransactionItem(
                    tx,
                    deleteTx,
                    key: ValueKey(tx.id),
                  ))
            ],
            // itemBuilder: (context, index) => TransactionItem(
            //   transactions[index],
            //   deleteTx,
            //   key: ValueKey(transactions[index].id),
            // ),
            // itemCount: transactions.length,
          );
  }
}
