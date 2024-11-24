import 'package:flutter/material.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  int selectedIndex = 0; // 선택된 버튼의 인덱스 (0: Caregiver, 1: Elder)

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
                  width: 300, // 로고 크기
                  height: 300, // 동일하게 크기 조정
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // 원형 이미지
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.cover, // 이미지가 컨테이너를 채우도록 조정
                    ),
                  ),
                ),
                const SizedBox(height: 40), // 로고와 역할 선택 버튼 사이 간격

                // Caregiver/Elder 선택 버튼
                ToggleButtons(
                  borderRadius: BorderRadius.circular(8), // 직사각형 모서리 둥글게
                  fillColor: Colors.grey[350], // 선택된 버튼 색상 (연한 회색)
                  selectedColor: Colors.black, // 선택된 버튼 텍스트 색상
                  color: Colors.black, // 모든 버튼의 기본 텍스트 색상
                  constraints: const BoxConstraints(
                    minHeight: 50, // 버튼 높이
                    minWidth: 100, // 버튼 너비
                  ),
                  isSelected: [selectedIndex == 0, selectedIndex == 1], // 선택 상태
                  onPressed: (int index) {
                    setState(() {
                      selectedIndex = index; // 선택된 인덱스 업데이트
                    });
                  },
                  children: const [
                    Text("Caregiver"),
                    Text("Elder"),
                  ],
                ),
                const SizedBox(height: 20), // 선택 버튼과 입력 필드 간 간격

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

                // Sign Up 버튼
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
                      // 회원가입 버튼 클릭 시 HomeScreen으로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
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
