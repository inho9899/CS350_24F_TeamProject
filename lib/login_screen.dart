import 'package:flutter/material.dart';
import 'home_screen.dart'; // HomeScreen 파일 임포트

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.cover, // 이미지가 컨테이너를 채우도록 조정
                    ),
                  ),
                ),
                const SizedBox(height: 40), // 로고와 입력 필드 사이 간격

                // E-mail (ID) 입력 필드
                TextField(
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
                    onPressed: () {
                      // 로그인 버튼 클릭 시 HomeScreen으로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
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
