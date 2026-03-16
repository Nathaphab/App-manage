import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/member_provider.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // สร้าง Provider และเรียก fetchMembers() เพื่อดึงข้อมูลจาก SQLite ทันทีที่เปิดแอป
        ChangeNotifierProvider(create: (_) => MemberProvider()..fetchMembers()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Club Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, // ใช้ UI ที่ดูทันสมัยขึ้น
      ),
      home: const DashboardScreen(), // กำหนดให้เปิดหน้า Dashboard เป็นหน้าแรก
    );
  }
}