import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // 추가된 import
import 'user_screen.dart'; // 사용자 화면
import 'detail_screen.dart'; // 상세정보 화면 (각 사용자 정보)

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1; // 현재 네비게이션 바 인덱스 (1: HomeScreen)

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
              const Text(
                "Welcome, Nupjuk!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Person A 정보 카드
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailScreen(personName: "Person A"),
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/person_a.jpg', // Person A 이미지
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "Person A",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Person B 정보 카드
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailScreen(personName: "Person B"),
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/person_b.jpg', // Person B 이미지
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "Person B",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            // 전화 앱 열기
            launchDialer();
          } else if (index == 1) {
            // 현재 페이지 (HomeScreen)
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UserScreen()),
            );
          }
          setState(() {
            _currentIndex = index;
          });
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

  void launchDialer() async {
    final Uri telUri = Uri(scheme: 'tel'); // 전화 앱 URI
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      // 실행 실패 시 오류 처리
      throw 'Could not launch $telUri';
    }
  }
}
