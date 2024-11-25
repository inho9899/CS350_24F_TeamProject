import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StepsGraph extends StatelessWidget {
  final String personName; // 사용자 이름 전달받기

  const StepsGraph({Key? key, required this.personName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<BarChartGroupData> barGroups = [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            y: 5000,
            colors: [Colors.blue],
            width: 20,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            y: 7000,
            colors: [Colors.blue],
            width: 20,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            y: 6000,
            colors: [Colors.blue],
            width: 20,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            y: 4000,
            colors: [Colors.blue],
            width: 20,
          ),
        ],
      ),
    ];

    final List<String> xLabels = ["10/27", "10/28", "10/29", "10/30"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Steps Graph',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "$personName - Steps Data",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
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
                        if (value.toInt() >= 0 &&
                            value.toInt() < xLabels.length) {
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
                        if (value % 2000 == 0) {
                          return '${value.toInt()}'; // Y축 제목: 2000 단위로 표시
                        }
                        return '';
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: 2000, // 수평선 간격
                  ),
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
        ],
      ),
    );
  }
}
