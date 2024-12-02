import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_screen.dart'; // LoginScreen 파일 임포트

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  int selectedIndex = 0; // 선택된 버튼의 인덱스 (0: Caregiver, 1: Elder)
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> register() async {
    final String name = nameController.text.trim();
    final String phone = phoneController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final int elderly = selectedIndex; // Caregiver: 0, Elder: 1

    if (name.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("모든 필드를 입력해주세요.")),
      );
      return;
    }

    final Uri url = Uri.parse('http://121.152.208.156:3000/auth/register');
    final Map<String, dynamic> body = {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "elderly": elderly,
    };

    try {
      final http.Response response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("회원가입이 성공적으로 완료되었습니다.")),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("회원가입 실패: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("오류 발생: $e")),
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
                  width: 300, // 로고 크기
                  height: 300, // 동일하게 크기 조정
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // 원형 이미지
                    image: const DecorationImage(
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

                // 이름 입력 필드
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: const TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // 입력 필드 간격

                // 전화번호 입력 필드
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone, // 전화번호 키보드 설정
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: const TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // 입력 필드 간격

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
                    onPressed: register, // 회원가입 요청
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
