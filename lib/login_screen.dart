import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // FirebaseMessaging import
import 'package:http/http.dart' as http; // HTTP 요청을 위해 패키지 추가
import 'dart:convert'; // JSON 변환을 위해 필요
import 'home_screen.dart'; // HomeScreen 파일 임포트

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> sendTokenToServer(String token) async {
    final url = Uri.parse('http://121.152.208.156:3000/auth/login'); // 서버의 로그인 API 엔드포인트
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}),
      );

      if (response.statusCode == 200) {
        print('토큰이 서버에 성공적으로 전송되었습니다.');
      } else {
        print('서버 전송 실패: ${response.statusCode}');
      }
    } catch (error) {
      print('서버 전송 중 에러 발생: $error');
    }
  }

  Future<void> handleLogin(BuildContext context) async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("이메일과 비밀번호를 입력해주세요.")),
      );
      return;
    }

    // FCM 토큰 가져오기
    final String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (fcmToken == null) {
      print('FCM 토큰을 가져오지 못했습니다.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("푸시 알림을 활성화해주세요.")),
      );
      return;
    }

    final Uri url = Uri.parse('http://121.152.208.156:3000/auth/login');
    final Map<String, dynamic> body = {
      "email": email,
      "password": password,
      "FCM": fcmToken,
    };

    try {
      final http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final String accessToken = responseData['accessToken'];
        print('로그인 성공: $accessToken');

        // HomeScreen으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("로그인 실패: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("서버 오류 발생: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200], // 배경색 설정
        padding: const EdgeInsets.symmetric(horizontal: 40), // 양쪽 패딩 추가
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 로고 이미지
                Container(
                  width: 300, // 로고 크기를 줄임
                  height: 300, // 동일하게 크기 조정
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // 원형 이미지
                    image: const DecorationImage(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.cover, // 이미지가 컨테이너를 채우도록 조정
                    ),
                  ),
                ),
                const SizedBox(height: 40), // 로고와 입력 필드 사이 간격

                // E-mail (ID) 입력 필드
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "E-mail ( ID )",
                    labelStyle: const TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // 입력 필드 간격

                // Password 입력 필드
                TextField(
                  controller: passwordController,
                  obscureText: true, // 비밀번호 마스킹
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 30), // 입력 필드와 버튼 간격

                // Login 버튼
                SizedBox(
                  width: double.infinity,
                  height: 50, // 버튼 높이
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // 버튼 배경색
                      foregroundColor: Colors.white, // 버튼 텍스트 색상
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => handleLogin(context), // 로그인 버튼 클릭 시 실행
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
