import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/member_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('club_members.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE members (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        studentId TEXT NOT NULL,
        year TEXT NOT NULL,
        position TEXT NOT NULL,
        status TEXT NOT NULL,
        phone TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertMember(Member member) async {
    final db = await instance.database;
    return await db.insert('members', member.toMap());
  }

  Future<List<Member>> getAllMembers() async {
    final db = await instance.database;
    final result = await db.query('members');
    return result.map((map) => Member.fromMap(map)).toList();
  }

  Future<int> updateMember(Member member) async {
    final db = await instance.database;
    return db.update('members', member.toMap(), where: 'id = ?', whereArgs: [member.id]);
  }

  Future<int> deleteMember(int id) async {
    final db = await instance.database;
    return await db.delete('members', where: 'id = ?', whereArgs: [id]);
  }
}