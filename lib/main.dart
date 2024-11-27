import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'welcome_screen.dart'; // WelcomeScreen 파일 임포트

// 백그라운드 메시지 처리 핸들러
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("백그라운드에서 메시지 수신: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp();

  // 백그라운드 메시지 처리 핸들러 등록
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(), // WelcomeScreen을 첫 화면으로 설정
    );
  }
}
