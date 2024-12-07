import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OutdoorAlertScreen extends StatelessWidget {
  final String personName;
  final String phone;
  final String time; // 외출 시간

  const OutdoorAlertScreen({
    Key? key,
    required this.personName,
    required this.phone,
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
            const SizedBox(height: 20),
            Text(
              "외출 시간: $time", // 외출 시간을 화면에 표시
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
                backgroundColor: Colors.blue,
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
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("전화 119"),
            ),
            const SizedBox(height: 20),
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
              child: Text("전화 $personName"),
            ),
          ],
        ),
      ),
    );
  }
}
