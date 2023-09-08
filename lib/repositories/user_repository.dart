import 'package:sqflite/sqflite.dart';
import 'package:tp_archi_mobile/db/database_connection.dart';

class UserRepository {
  late DatabaseConnection _databaseConnection;

  UserRepository() {
    _databaseConnection = DatabaseConnection();
    print("UserRepository");
  }

  static Database? _database;

  String table = "users";

  Future<Database?> get database async {
    if (_database != null) {
      print("Database already exist");
      return _database;
    } else {
      print("Database created");
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  Future<int?> verifyUser(String userName, String userPassword) async {
    var connection = await database;
    List<Map<String, Object?>>? users = await connection?.query(
      table,
      where: 'username = ? AND userpassword = ?',
      whereArgs: [userName, userPassword],
    );

    if (users!.isNotEmpty) {
      return users[0]['id'] as int?;
    } else {
      return -1;
    }
  }

  Future<int?> insertData(Map<String, dynamic> data) async {
    var connection = await database;
    List<Map<String, Object?>>? existingUsers = await connection?.query(
      table,
      where: 'username = ?',
      whereArgs: [data['userName']],
    );

    if (existingUsers!.isNotEmpty) {
      return -1;
    }

    return await connection?.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>?> readData() async {
    var connection = await database;

    return await connection?.query(table);
  }

  Future<List<Map<String, dynamic>>?> readDataById(int userId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id = ?', whereArgs: [userId]);
  }

  Future<int?> updateData(Map<String, dynamic> data) async {
    var connection = await database;
    print(data);
    return await connection?.update(table, data, where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<int?> deleteDataById(int userId) async {
    var connection = await database;
    return await connection?.delete(table, where: 'id = ?', whereArgs: [userId]);
  }
}
