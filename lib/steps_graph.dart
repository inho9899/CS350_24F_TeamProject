import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StepsGraph extends StatelessWidget {
  const StepsGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<BarChartGroupData> barGroups = [
      BarChartGroupData(x: 0, barRods: [BarChartRodData(y: 5000, colors: [Colors.blue], width: 20)]),
      BarChartGroupData(x: 1, barRods: [BarChartRodData(y: 7000, colors: [Colors.blue], width: 20)]),
      BarChartGroupData(x: 2, barRods: [BarChartRodData(y: 6000, colors: [Colors.blue], width: 20)]),
      BarChartGroupData(x: 3, barRods: [BarChartRodData(y: 4000, colors: [Colors.blue], width: 20)]),
    ];

    final List<String> xLabels = ["10/27", "10/28", "10/29", "10/30"];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Steps Graph'),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 350,
          child: BarChart(
            BarChartData(
              barGroups: barGroups,
              titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  margin: 10,
                  getTextStyles: (value) => const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  getTitles: (value) {
                    if (value.toInt() >= 0 && value.toInt() < xLabels.length) {
                      return xLabels[value.toInt()]; // X축 제목
                    }
                    return '';
                  },
                ),
                leftTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  margin: 10,
                  getTextStyles: (value) => const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  getTitles: (value) {
                    return '${value.toInt()}'; // Y축 제목
                  },
                ),
              ),
              gridData: FlGridData(show: true),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  left: BorderSide(color: Colors.black, width: 1),
                  bottom: BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
