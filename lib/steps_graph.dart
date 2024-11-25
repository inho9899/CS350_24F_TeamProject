import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math'; // 랜덤 데이터 생성을 위한 import

class StepsGraph extends StatelessWidget {
  final String personName; // 사용자 이름 전달받기

  const StepsGraph({Key? key, required this.personName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 현재 날짜 기준으로 최근 7일 동안의 더미 걸음 수 데이터 생성
    final List<DateTime> recentDays = List.generate(
      7,
          (index) => DateTime.now().subtract(Duration(days: index)),
    ).reversed.toList(); // 날짜를 최신순으로 정렬

    final List<int> stepsData = List.generate(7, (index) => 4000 + Random().nextInt(6000));

    // BarChartGroupData 생성
    final List<BarChartGroupData> barGroups = List.generate(
      7,
          (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            y: stepsData[index].toDouble(),
            colors: [Colors.blue],
            width: 20,
          ),
        ],
      ),
    );

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
                        // X축: 최근 7일의 날짜 표시
                        if (value.toInt() >= 0 && value.toInt() < recentDays.length) {
                          final date = recentDays[value.toInt()];
                          return "${date.month}/${date.day}"; // MM/DD 형식
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
                          return '${value.toInt()}'; // Y축: 2000 단위로 표시
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
