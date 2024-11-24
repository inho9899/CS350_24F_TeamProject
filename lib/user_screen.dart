import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController elderController = TextEditingController(); // 입력값 제어

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Image.asset('assets/logo.png', width: 30, height: 30), // 로고 이미지
            const SizedBox(width: 10),
            const Text(
              "Smart Health Monitoring",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 사용자 정보 카드
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // 사용자 이메일 및 정보
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "E-mail (ID)",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Edit information",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      // 사용자 이미지 (프로필)
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Add Elder 입력창
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: elderController, // 입력값 컨트롤러
                      decoration: InputDecoration(
                        labelText: "Add Elder",
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      // Add Elder 버튼 동작
                      final String elderName = elderController.text.trim();
                      if (elderName.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Elder '$elderName' added!"),
                          ),
                        );
                        elderController.clear(); // 입력값 초기화
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter a valid name."),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              const Divider(color: Colors.grey),

              // Delete ID 버튼
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // 버튼 배경색
                    foregroundColor: Colors.white, // 텍스트 색상
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Delete ID 버튼 동작
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Delete ID"),
                        content: const Text(
                          "Are you sure you want to delete this ID?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // 취소
                            },
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // 삭제 실행 후 닫기
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("ID deleted."),
                                ),
                              );
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    "Delete ID",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // 현재 탭: UserScreen
        onTap: (index) {
          if (index == 0) {
            // 전화 앱으로 이동
          } else if (index == 1) {
            Navigator.pop(context); // HomeScreen으로 이동
          } else if (index == 2) {
            // 현재 UserScreen
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
