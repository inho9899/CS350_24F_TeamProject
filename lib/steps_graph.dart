import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StepsGraph extends StatefulWidget {
  final String personName;
  final String elderlyID;
  final String token;

  const StepsGraph({
    Key? key,
    required this.personName,
    required this.elderlyID,
    required this.token,
  }) : super(key: key);

  @override
  _StepsGraphState createState() => _StepsGraphState();
}

class _StepsGraphState extends State<StepsGraph> {
  List<BarChartGroupData> barGroups = [];
  List<DateTime> recentDays = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStepsData();
  }

  Future<void> fetchStepsData() async {
    final Uri url = Uri.parse('http://121.152.208.156:3000/caregiver/sensorData');

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${widget.token}",
        },
        body: jsonEncode({
          "elderlyID": widget.elderlyID,
          "type": "walking",
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<String> times = List<String>.from(data['time']);
        final List<int> values = List<int>.from(data['walk']);

        // 데이터를 최근 날짜 순으로 정렬
        List<DateTime> days = [];
        for (String time in times) {
          days.add(DateTime.parse(time));
        }

        // 그래프 데이터 생성
        List<BarChartGroupData> groups = [];
        for (int i = 0; i < days.length; i++) {
          groups.add(
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  y: values[i].toDouble(),
                  colors: [Colors.blue],
                  width: 20,
                ),
              ],
            ),
          );
        }

        setState(() {
          barGroups = groups;
          recentDays = days;
          isLoading = false;
        });
      } else {
        print("Failed to fetch steps data: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load data: ${response.body}")),
        );
      }
    } catch (e) {
      print("Error fetching steps data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occurred: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Steps Graph',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "${widget.personName} - Steps Data",
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
                        if (value.toInt() >= 0 && value.toInt() < recentDays.length) {
                          final date = recentDays[value.toInt()];
                          return "${date.month}/${date.day}";
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
                          return '${value.toInt()}';
                        }
                        return '';
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: 2000,
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
