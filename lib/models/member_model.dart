class Member {
  int? id;
  String name;
  String studentId;
  String year;
  String position;
  String status;
  String phone;

  Member({
    this.id,
    required this.name,
    required this.studentId,
    required this.year,
    required this.position,
    required this.status,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'studentId': studentId,
      'year': year,
      'position': position,
      'status': status,
      'phone': phone,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['id'],
      name: map['name'],
      studentId: map['studentId'],
      year: map['year'],
      position: map['position'],
      status: map['status'],
      phone: map['phone'],
    );
  }
}