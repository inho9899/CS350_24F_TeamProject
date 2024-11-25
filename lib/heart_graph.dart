import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class HeartGraph extends StatelessWidget {
  final String personName; // 사람 이름을 전달받기 위한 변수

  const HeartGraph({Key? key, required this.personName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 현재 시간 기준으로 1시간 동안의 심박수 데이터 생성
    final DateTime now = DateTime.now();
    final List<FlSpot> heartRateData = List.generate(
      8,
          (index) {
        final int minuteOffset = index * 10;
        final double xValue = (60 - minuteOffset).toDouble();
        final double yValue = 75 + Random().nextInt(10) - 5; // Y축 심박수 값
        return FlSpot(xValue, yValue);
      },
    ).reversed.toList(); // 데이터를 정렬 (가장 오래된 값이 먼저 나오도록)

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Heart Rate (BPM)',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 화면 중앙에 배치
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "$personName - Heart Rate",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20), // 제목과 그래프 간 간격
          Center(
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
                        // X축: 10분 단위로만 범례 표시
                        if (value.toInt() % 10 == 0) {
                          final int minute = now
                              .subtract(Duration(minutes: 60 - value.toInt()))
                              .minute;
                          return '${minute.toString().padLeft(2, '0')}m';
                        }
                        return ''; // 나머지 값은 범례를 숨김
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
                        if (value % 20 == 0) {
                          return '${value.toInt()} BPM'; // 20 단위로만 표시
                        }
                        return '';
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: 20, // 수평선 간격
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
