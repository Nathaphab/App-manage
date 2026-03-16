import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/member_model.dart';
import '../providers/member_provider.dart';

class AddEditScreen extends StatefulWidget {
  final Member? member; // ถ้ามีค่าแสดงว่ากำลัง Edit ถ้า null แสดงว่า Add ใหม่

  const AddEditScreen({super.key, this.member});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late String name;
  late String studentId;
  late String position;
  late String phone;
  String year = '1';
  String status = 'Active';

  @override
  void initState() {
    super.initState();
    if (widget.member != null) {
      name = widget.member!.name;
      studentId = widget.member!.studentId;
      year = widget.member!.year;
      position = widget.member!.position;
      status = widget.member!.status;
      phone = widget.member!.phone;
    } else {
      name = '';
      studentId = '';
      position = '';
      phone = '';
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newMember = Member(
        id: widget.member?.id,
        name: name,
        studentId: studentId,
        year: year,
        position: position,
        status: status,
        phone: phone,
      );

      if (widget.member == null) {
        Provider.of<MemberProvider>(context, listen: false).addMember(newMember);
        // แจ้งเตือนเมื่อเพิ่มสำเร็จ
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('บันทึกข้อมูลสำเร็จ!'), backgroundColor: Colors.green),
        );
      } else {
        Provider.of<MemberProvider>(context, listen: false).updateMember(newMember);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('อัปเดตข้อมูลสำเร็จ!'), backgroundColor: Colors.green),
        );
      }

      Navigator.pop(context); // กลับไปหน้า Dashboard
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.member == null ? 'เพิ่มสมาชิกใหม่' : 'แก้ไขข้อมูลสมาชิก'),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'ชื่อ-นามสกุล', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'กรุณากรอกชื่อ' : null,
                onSaved: (value) => name = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: studentId,
                decoration: const InputDecoration(labelText: 'รหัสนักศึกษา', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'กรุณากรอกรหัสนักศึกษา' : null,
                onSaved: (value) => studentId = value!,
              ),
              const SizedBox(height: 12),
              // ใช้ Dropdown สำหรับชั้นปี
              DropdownButtonFormField<String>(
                value: year,
                decoration: const InputDecoration(labelText: 'ชั้นปี', border: OutlineInputBorder()),
                items: ['1', '2', '3', '4'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text('ปี $value'));
                }).toList(),
                onChanged: (newValue) => setState(() => year = newValue!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: position,
                decoration: const InputDecoration(labelText: 'ตำแหน่ง', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'กรุณากรอกตำแหน่ง' : null,
                onSaved: (value) => position = value!,
              ),
              const SizedBox(height: 12),
              // ใช้ Dropdown สำหรับสถานะ
              DropdownButtonFormField<String>(
                value: status,
                decoration: const InputDecoration(labelText: 'สถานะ', border: OutlineInputBorder()),
                items: ['Active', 'Inactive'].map((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                onChanged: (newValue) => setState(() => status = newValue!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: phone,
                decoration: const InputDecoration(labelText: 'เบอร์โทร', border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'กรุณากรอกเบอร์โทร' : null,
                onSaved: (value) => phone = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue,
                ),
                child: const Text('บันทึกข้อมูล', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}