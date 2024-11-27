import 'package:flutter/material.dart';

class MissedMedicineScreen extends StatelessWidget {
  final String personName;

  const MissedMedicineScreen({Key? key, required this.personName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "약 복용 알림",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange, // 알림 강조를 위해 주황색 배경
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.medical_services,
              color: Colors.orange,
              size: 100,
            ), // 약 복용 아이콘 추가
            const SizedBox(height: 20),
            Text(
              "$personName이 약을 복용하지 않았습니다.",
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
                backgroundColor: Colors.orange,
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
