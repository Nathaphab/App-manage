import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/member_provider.dart';
import 'add_edit_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _selectedFilter; // สำหรับเก็บค่าการกรองสถานะ

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ระบบจัดการสมาชิกชมรม'),
        backgroundColor: Colors.blue.shade100,
        actions: [
          // --- ระบบกรองข้อมูล (Filter) ---
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            tooltip: 'กรองสถานะ',
            onSelected: (value) {
              setState(() {
                _selectedFilter = value == 'All' ? null : value;
              });
              // เรียกฟังก์ชัน filter ใน Provider
              Provider.of<MemberProvider>(context, listen: false).filterMembers(null, _selectedFilter);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('แสดงทั้งหมด')),
              const PopupMenuItem(value: 'Active', child: Text('เฉพาะสถานะ: Active')),
              const PopupMenuItem(value: 'Inactive', child: Text('เฉพาะสถานะ: Inactive')),
            ],
          )
        ],
      ),
      body: Consumer<MemberProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // --- ส่วนที่ 1: Dashboard สรุปจำนวน ---
              Card(
                margin: const EdgeInsets.all(12.0),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('ทั้งหมด', provider.totalMembers.toString(), Colors.blue),
                      _buildStatItem('Active', provider.activeMembers.toString(), Colors.green),
                    ],
                  ),
                ),
              ),
              
              // --- ส่วนที่ 1.5: ช่องค้นหา (Search) ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ค้นหาชื่อ หรือ รหัสนักศึกษา...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onChanged: (value) {
                    // เรียกฟังก์ชันค้นหาแบบ Real-time
                    Provider.of<MemberProvider>(context, listen: false).searchMembers(value);
                  },
                ),
              ),
              const SizedBox(height: 8),
              const Divider(height: 1),
              
              // --- ส่วนที่ 2: List แสดงรายการสมาชิก ---
              Expanded(
                child: provider.members.isEmpty
                    ? const Center(child: Text('ไม่พบข้อมูลสมาชิก'))
                    : ListView.builder(
                        itemCount: provider.members.length,
                        itemBuilder: (context, index) {
                          final member = provider.members[index];
                          
                          // --- ใช้ Dismissible สำหรับปัดลบ (ได้คะแนนพิเศษ) ---
                          return Dismissible(
                            key: Key(member.id.toString()),
                            direction: DismissDirection.endToStart, // ปัดจากขวาไปซ้าย
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            // --- Dialog ยืนยันก่อนลบ (ได้คะแนนพิเศษ) ---
                            confirmDismiss: (direction) async {
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('ยืนยันการลบ'),
                                    content: Text('ต้องการลบข้อมูลของ ${member.name} ใช่หรือไม่?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: const Text('ยกเลิก'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: const Text('ลบ', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onDismissed: (direction) {
                              provider.deleteMember(member.id!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('ลบข้อมูล ${member.name} สำเร็จ'),
                                  backgroundColor: Colors.red.shade400,
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: Text('ปี ${member.year}'),
                                ),
                                title: Text(member.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text('${member.studentId} | ${member.position} \nโทร: ${member.phone}'),
                                isThreeLine: true,
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Chip(
                                      label: Text(
                                        member.status,
                                        style: const TextStyle(color: Colors.white, fontSize: 12),
                                      ),
                                      backgroundColor: member.status.toLowerCase() == 'active' 
                                          ? Colors.green 
                                          : Colors.grey,
                                    ),
                                    // --- ปุ่มแก้ไข (Edit) ---
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddEditScreen(member: member),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Widget ย่อยสำหรับแสดงตัวเลขใน Dashboard
  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}