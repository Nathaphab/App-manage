import 'package:flutter/material.dart';
import '../models/member_model.dart';
import '../services/database_helper.dart';

class MemberProvider extends ChangeNotifier {
  List<Member> _members = [];
  List<Member> _filteredMembers = []; // เอาไว้เก็บข้อมูลที่ผ่านการค้นหา/กรอง

  List<Member> get members => _filteredMembers.isNotEmpty ? _filteredMembers : _members;
  
  // Dashboard Getters
  int get totalMembers => _members.length;
  int get activeMembers => _members.where((m) => m.status.toLowerCase() == 'active').length;
  
  int getMembersByYear(String year) {
    return _members.where((m) => m.year == year).length;
  }

  // ดึงข้อมูลจากฐานข้อมูล
  Future<void> fetchMembers() async {
    _members = await DatabaseHelper.instance.getAllMembers();
    _filteredMembers = _members; // ตอนแรกให้แสดงทั้งหมด
    notifyListeners();
  }

  Future<void> addMember(Member member) async {
    await DatabaseHelper.instance.insertMember(member);
    await fetchMembers();
  }

  Future<void> updateMember(Member member) async {
    await DatabaseHelper.instance.updateMember(member);
    await fetchMembers();
  }

  Future<void> deleteMember(int id) async {
    await DatabaseHelper.instance.deleteMember(id);
    await fetchMembers();
  }

  // --- เพิ่มฟังก์ชันค้นหา (Search) ที่หายไป ---
  void searchMembers(String query) {
    if (query.isEmpty) {
      _filteredMembers = _members;
    } else {
      _filteredMembers = _members.where((member) {
        return member.name.toLowerCase().contains(query.toLowerCase()) || 
               member.studentId.contains(query);
      }).toList();
    }
    notifyListeners();
  }

  // --- เพิ่มฟังก์ชันกรองสถานะ (Filter) ที่หายไป ---
  void filterMembers(String? year, String? status) {
    if (status == null || status == 'All') {
      _filteredMembers = _members;
    } else {
      _filteredMembers = _members.where((member) {
        return member.status.toLowerCase() == status.toLowerCase();
      }).toList();
    }
    notifyListeners();
  }
}