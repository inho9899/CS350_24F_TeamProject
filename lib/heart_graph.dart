import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HeartGraph extends StatefulWidget {
  final String personName;
  final String elderlyID;
  final String token;

  const HeartGraph({
    Key? key,
    required this.personName,
    required this.elderlyID,
    required this.token,
  }) : super(key: key);

  @override
  _HeartGraphState createState() => _HeartGraphState();
}

class _HeartGraphState extends State<HeartGraph> {
  List<FlSpot> heartRateData = []; // 그래프 데이터
  bool isLoading = true; // 로딩 상태 확인
  List<String> xLabels = []; // X축 라벨

  @override
  void initState() {
    super.initState();
    fetchHeartRateData();
  }

  Future<void> fetchHeartRateData() async {
    final Uri url = Uri.parse('http://121.152.208.156:3000/caregiver/sensorData');

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${widget.token}",
        },
        body: jsonEncode({
          "elderlyID": int.parse(widget.elderlyID), // String -> int 변환
          "type": "heartRate",
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> times = data['time'] ?? [];
        final List<dynamic> values = data['heartRate'] ?? [];

        // 데이터 정렬
        List<Map<String, dynamic>> dataPoints = List.generate(
          times.length,
              (index) => {
            "time": DateTime.parse(times[index]),
            "value": values[index].toDouble(),
          },
        );

        dataPoints.sort((a, b) => a["time"].compareTo(b["time"])); // 시간 기준으로 정렬

        List<FlSpot> spots = [];
        List<String> labels = [];

        for (int i = 0; i < dataPoints.length; i++) {
          final DateTime time = dataPoints[i]["time"];
          final double xValue = i.toDouble(); // 순차적인 x값
          final double yValue = dataPoints[i]["value"];
          spots.add(FlSpot(xValue, yValue));
          labels.add("${time.hour}:${time.minute.toString().padLeft(2, '0')}"); // 시간 형식
        }

        setState(() {
          heartRateData = spots;
          xLabels = labels;
          isLoading = false;
        });
      } else {
        print("Failed to fetch heart rate data: ${response.body}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching heart rate data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Heart Rate (BPM)',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : heartRateData.isEmpty
          ? Center(
        child: Text(
          "No heart rate data available.",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "${widget.personName} - Heart Rate",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              height: 300,
              width: 350,
              child: LineChart(
                LineChartData(
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
                        if (value.toInt() >= 0 &&
                            value.toInt() < xLabels.length) {
                          return xLabels[value.toInt()]; // 시간 표시
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
                        if (value % 10 == 0) {
                          return '${value.toInt()} BPM';
                        }
                        return '';
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: 10, // 심박수 간격
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
