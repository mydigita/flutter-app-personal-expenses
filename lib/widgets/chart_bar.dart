import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentage;
  const ChartBar({
    super.key,
    required this.label,
    required this.spendingAmount,
    required this.spendingPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: null,
              height: constraints.maxHeight * 0.10,
              child: FittedBox(child: Text(label)),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              color: null,
              height: constraints.maxHeight * 0.5,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 2,
                    child: FractionallySizedBox(
                      heightFactor: spendingPercentage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              color: null,
              height: constraints.maxHeight * 0.10,
              child: FittedBox(
                  child: Text(
                '\$${spendingAmount.toStringAsFixed(0)}',
              )),
            ),
          ],
        );
      },
    );
  }
}
