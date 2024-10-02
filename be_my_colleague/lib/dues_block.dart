import 'package:be_my_colleague/model/due.dart';
import 'package:flutter/material.dart';

class DueBlock extends StatelessWidget {
  final Due due;

  DueBlock({required this.due});

  @override
  Widget build(BuildContext context) {
    int year = due.date.year;
    int month = due.date.month;
    return Card(
        child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child:  Row(
              children: [
                Text('$year년 $month월'),
                Text('   '),
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          due.payed ? Icons.check : Icons.cancel,
                          color: due.payed ? Colors.green : Colors.red,)
                        ],
                )),
        ],
    )));
  }
}
