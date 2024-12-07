import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LowHeartRateScreen extends StatelessWidget {
  final String personName;
  final String phone;
  final String value; // 심박수 값
  final String time; // 시간

  const LowHeartRateScreen({
    Key? key,
    required this.personName,
    required this.phone,
    required this.value,
    required this.time,
  }) : super(key: key);

  // 전화 URL을 여는 함수
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw '전화 연결을 할 수 없습니다.';
    }
  }

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
            const SizedBox(height: 20),
            Text(
              "심박수: $value BPM", // 심박수 표시
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              "시간: $time", // 시간 표시
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _makePhoneCall('119'); // 119로 전화 걸기
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("call 119"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _makePhoneCall(phone); // personName의 전화번호로 전화 걸기
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("call $personName"),
            ),
          ],
        ),
      ),
    );
  }
}
