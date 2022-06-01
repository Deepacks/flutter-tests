import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
    this.label,
    this.spendingAmount,
    this.spendingPctOfTotal, {
    Key? key,
  }) : super(key: key);

  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(child: Text('€$spendingAmount')),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
