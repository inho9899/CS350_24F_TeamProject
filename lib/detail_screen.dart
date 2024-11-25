import 'package:flutter/material.dart';
import 'heart_graph.dart'; // Heart Graph 화면 import
import 'steps_graph.dart'; // Steps Graph 화면 import

class DetailScreen extends StatelessWidget {
  final String personName;

  const DetailScreen({Key? key, required this.personName}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                personName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // 상태 카드: Not at Home
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Image.asset('assets/home_icon.png', width: 40), // 아이콘
                  title: const Text("Not at Home"),
                  subtitle: const Text("Leave at 14:30"),
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
                      builder: (context) => const HeartGraph(),
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    leading: Image.asset('assets/heart_icon.png', width: 40), // 아이콘
                    title: const Text("72 BPM"),
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
                      builder: (context) => const StepsGraph(),
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    leading: Image.asset('assets/steps_icon.png', width: 40), // 아이콘
                    title: const Text("1234 walks"),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 상태 카드: Medication
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Image.asset('assets/medicine_icon.png', width: 40), // 아이콘
                  title: const Text("Morning : 07:32"),
                  subtitle: const Text("Afternoon : 12:16"),
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
