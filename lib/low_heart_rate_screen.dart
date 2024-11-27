import 'package:flutter/material.dart';

class LowHeartRateScreen extends StatelessWidget {
  final String personName;

  const LowHeartRateScreen({Key? key, required this.personName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "심박수 경고",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red, // 경고를 강조하기 위해 빨간색 배경
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning,
              color: Colors.red,
              size: 100,
            ), // 경고 아이콘 추가
            const SizedBox(height: 20),
            Text(
              "$personName의 심박수가 너무 낮습니다. 조치를 취하세요.",
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
                backgroundColor: Colors.red,
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
