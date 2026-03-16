# icon app
<img width="87" height="107" alt="Image" src="https://github.com/user-attachments/assets/d2ea0e22-9f41-42a0-aaa2-c68e854d841c" />

## Within the application
<img width="433" height="894" alt="Image" src="https://github.com/user-attachments/assets/e1cc52d3-f66e-4a06-a0a8-a21b65c0578c" />

<img width="432" height="899" alt="Image" src="https://github.com/user-attachments/assets/eb3346c3-a1a4-475f-bc3b-d5dd792d2af3" />

<img width="449" height="893" alt="Image" src="https://github.com/user-attachments/assets/faf7d912-19b4-4ff4-bd7d-3e49b5a446d8" />

## แอปบันทึกสมาชิกชมรม
## นาย ณฐภาพ สายหล้า
## ระบบจัดการสมาชิกชมรม (Member Management App)
**รายวิชา:** การพัฒนาแอปพลิเคชันมือถือ (Mobile Application Development)
**ผู้จัดทำ:** นายณฐภาพ สายหล้า 
**รหัสนักศึกษา:** 67543210054-2

## 📋 โจทย์และข้อกำหนดของโปรเจกต์
สร้างแอปพลิเคชันสำหรับจัดการข้อมูลสมาชิกชมรม โดยมีคุณสมบัติดังนี้:
1. **หน้า Dashboard:** แสดงผลสรุปจำนวนสมาชิกทั้งหมด และจำนวนสมาชิกที่มีสถานะ Active
2. **ระบบจัดการข้อมูล (CRUD):** - สามารถเพิ่มรายชื่อสมาชิกใหม่ได้
   - สามารถแก้ไขข้อมูลสมาชิกเดิมได้
   - สามารถลบข้อมูลสมาชิกได้ (ปุ่มถังขยะ)
3. **ระบบค้นหาและกรองข้อมูล:**
   - มีช่อง Search สำหรับค้นหาชื่อหรือรหัสนักศึกษา
   - มีปุ่ม Filter สำหรับกรองสถานะสมาชิก (Active / Inactive)
4. **การจัดเก็บข้อมูล:** ใช้ฐานข้อมูล SQLite (sqflite) เพื่อให้ข้อมูลคงอยู่แม้ปิดแอปพลิเคชัน
5. **การออกแบบ:** - รองรับการแสดงผลทั้ง Android และ iOS
   - ปรับแต่ง App Icon และชื่อแอปพลิเคชันให้ถูกต้องตามกำหนด

## 🛠️ เทคโนโลยีที่ใช้
* **Framework:** Flutter
* **Language:** Dart
* **State Management:** Provider
* **Database:** SQLite (sqflite)
* **Icon Tool:** Flutter Launcher Icons

## 🚀 วิธีการรันโปรเจกต์
1. Clone โปรเจกต์จาก GitHub
2. รันคำสั่ง `flutter pub get` เพื่อติดตั้ง Library
3. รันคำสั่ง `flutter run` เพื่อเริ่มทำงานบน Simulator หรืออุปกรณ์จริง
