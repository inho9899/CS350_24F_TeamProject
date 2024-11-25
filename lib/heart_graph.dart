import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HeartGraph extends StatelessWidget {
  const HeartGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> heartRateData = [
      FlSpot(0, 80),
      FlSpot(1, 82),
      FlSpot(2, 78),
      FlSpot(3, 85),
      FlSpot(4, 87),
      FlSpot(5, 83),
      FlSpot(6, 79),
      FlSpot(7, 84),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart Rate (BPM)'),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 350,
          child: LineChart(
            LineChartData(
              maxY: 100,
              minY: 60,
              lineBarsData: [
                LineChartBarData(
                  spots: heartRateData,
                  isCurved: true,
                  colors: [Colors.red],
                  barWidth: 4,
                  belowBarData: BarAreaData(show: false),
                  dotData: FlDotData(show: true),
                ),
              ],
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
                    return 'T${value.toInt()}'; // X축 제목
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
                    return '${value.toInt()} BPM'; // Y축 제목
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
