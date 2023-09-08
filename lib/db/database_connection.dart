import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    print("DatabaseConnection");
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_users');
    var database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database database, int version) async {
    String sql = """CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        userId INTEGER,
        userName TEXT,
        userPassword TEXT
      );""";
    await database.execute(sql);
    print("Database Created");
  }
}
