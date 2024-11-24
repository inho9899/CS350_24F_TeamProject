import 'package:flutter/material.dart';
import 'login_screen.dart'; // LoginScreen 파일 임포트
import 'signup_screen.dart'; // SignupScreen 파일 임포트

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200], // 배경색 설정
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 400, // 로고의 너비
                height: 400, // 로고의 높이
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // 원형 이미지
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'), // 로고 이미지
                    fit: BoxFit.cover, // 이미지가 컨테이너를 채우도록 조정
                  ),
                ),
              ),
              const SizedBox(height: 10), // 간격을 줄임
              const Text(
                "WELCOME!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30), // 버튼과의 간격
              SizedBox(
                width: 200, // 버튼 너비
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400], // 배경색
                    foregroundColor: Colors.black, // 텍스트 색상
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // E-mail Login 버튼 동작: LoginScreen으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    "E-mail Login",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 200, // 버튼 너비
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // 배경색
                    foregroundColor: Colors.white, // 텍스트 색상
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Register 버튼 동작: SignupScreen으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()),
                    );
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
