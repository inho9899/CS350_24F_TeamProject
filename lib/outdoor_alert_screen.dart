import 'package:flutter/material.dart';

class OutdoorAlertScreen extends StatelessWidget {
  final String personName;

  const OutdoorAlertScreen({Key? key, required this.personName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "외출 알림",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue, // 알림 강조를 위해 파란색 배경
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.directions_walk,
              color: Colors.blue,
              size: 100,
            ), // 외출 아이콘 추가
            const SizedBox(height: 20),
            Text(
              "$personName이 외출 중입니다.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // 뒤로 가기 버튼
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("돌아가기"),
            ),
          ],
        ),
      ),
    );
  }
}
