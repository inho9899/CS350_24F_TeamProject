import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'heart_graph.dart'; // Heart Graph 화면 import
import 'steps_graph.dart'; // Steps Graph 화면 import

class DetailScreen extends StatefulWidget {
  final String personName;
  final String elderlyID;
  final String token;

  const DetailScreen({
    Key? key,
    required this.personName,
    required this.elderlyID,
    required this.token,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Map<String, dynamic> sensorData = {}; // 센서 데이터를 저장할 변수
  bool isLoading = true; // 로딩 상태 확인

  @override
  void initState() {
    super.initState();
    fetchSensorData();
  }

  Future<void> fetchSensorData() async {
    final Uri url = Uri.parse('http://121.152.208.156:3000/caregiver/sensorAllData');

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${widget.token}",
        },
        body: jsonEncode({"elderlyID": widget.elderlyID}),
      );

      if (response.statusCode == 200) {
        setState(() {
          sensorData = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        print("Failed to fetch sensor data: ${response.body}");
      }
    } catch (e) {
      print("Error fetching sensor data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Image.asset('assets/logo.png', width: 30, height: 30), // 로고 이미지
            const SizedBox(width: 10),
            const Text(
              "Smart Health Monitoring",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // 로딩 표시
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 사용자 이름 표시
              Text(
                widget.personName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // 상태 카드: Heart Rate
              GestureDetector(
                onTap: () {
                  // Heart Graph 화면으로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HeartGraph(
                        personName: widget.personName,
                        elderlyID: widget.elderlyID,
                        token: widget.token,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    leading: Image.asset('assets/heart_icon.png', width: 40), // 아이콘
                    title: Text("${sensorData['heartRate']?[1] ?? 'N/A'} BPM"),
                    subtitle: Text("Last Update: ${sensorData['heartRate']?[0] ?? 'N/A'}"),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 상태 카드: Steps
              GestureDetector(
                onTap: () {
                  // Steps Graph 화면으로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StepsGraph(
                        personName: widget.personName,
                        elderlyID: widget.elderlyID,
                        token: widget.token,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    leading: Image.asset('assets/steps_icon.png', width: 40), // 아이콘
                    title: Text("${sensorData['walking']?[1] ?? 'N/A'} Steps"),
                    subtitle: Text("Last Update: ${sensorData['walking']?[0] ?? 'N/A'}"),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 상태 카드: Medication
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Image.asset('assets/medicine_icon.png', width: 40), // 아이콘
                  title: Text("Morning: ${sensorData['medicine']?[0] ?? 'N/A'}"),
                  subtitle: Text("Afternoon: ${sensorData['medicine']?[1] ?? 'N/A'}"),
                ),
              ),
              const SizedBox(height: 20),

              // 상태 카드: Outdoor
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Image.asset('assets/home_icon.png', width: 40), // 아이콘
                  title: Text(
                    sensorData['outdoor'] != null && sensorData['outdoor']!.isNotEmpty
                        ? "Last Update: ${sensorData['outdoor']?[0]}"
                        : "N/A",
                  ),
                  subtitle: Text(
                    sensorData['outdoor'] != null && sensorData['outdoor']!.isNotEmpty
                        ? "Status: ${sensorData['outdoor']?[1]}"
                        : "No outdoor data available",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // 현재 네비게이션 탭 설정
        onTap: (index) {
          if (index == 0) {
            // 전화 앱으로 이동
          } else if (index == 1) {
            Navigator.pop(context); // 이전 화면으로 돌아가기
          } else if (index == 2) {
            // 사용자 화면으로 이동
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
