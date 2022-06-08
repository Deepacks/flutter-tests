import 'package:flutter/material.dart';

import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    required this.transaction,
    required this.deleteTx,
    Key? key,
  }) : super(key: key);

  final Transaction transaction;
  final Function(String p1) deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('€${transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: const TextStyle(fontFamily: "Quicksand"),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
                onPressed: () => deleteTx(transaction.id),
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(Theme.of(context).errorColor),
                ),
              )
            : IconButton(
                onPressed: () => deleteTx(transaction.id),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
