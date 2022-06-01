import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions, this.deleteTx, {Key? key})
      : super(key: key);

  final List<Transaction> transactions;
  final Function(String) deleteTx;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 580,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transactions added yet.',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) => Card(
                elevation: 4,
                margin: const EdgeInsets.all(5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('€${transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                    style: const TextStyle(fontFamily: "Quicksand"),
                  ),
                  trailing: IconButton(
                    onPressed: () => deleteTx(transactions[index].id),
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
              itemCount: transactions.length,
            ),
    );
  }
}
