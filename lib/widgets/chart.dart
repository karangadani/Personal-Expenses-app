import 'package:flutter/material.dart';
import '../models/transection.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transection> recentTransection;

  Chart(this.recentTransection);

  List<Map<String, Object>> get groupedTransectionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalsum = 0.0;

      for (var i = 0; i < recentTransection.length; i++) {
        if (recentTransection[i].date.day == weekDay.day &&
            recentTransection[i].date.month == weekDay.month &&
            recentTransection[i].date.year == weekDay.year) {
          totalsum += recentTransection[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalsum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalsum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransectionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransectionValues);
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransectionValues.map((data) {
            return Flexible(
                fit: FlexFit.tight,
                        child: ChartBar(data['day'], data['amount'],
                  totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
