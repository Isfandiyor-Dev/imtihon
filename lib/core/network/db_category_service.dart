import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbCategoryService {
  late Database _database;
  String tableName = "category";

  DbCategoryService._internal();

  static final DbCategoryService _instanse = DbCategoryService._internal();

  factory DbCategoryService() => _instanse;

  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/mydatabase.db";
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: createDatabase,
    );
  }

  Future<void> createDatabase(Database db) async {
    String query = """
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT
    )
""";
    db.execute(query);
  }

  Future<List<Map<String, Object?>>> getCategories() async {
    try {
      final data = await _database.query(tableName);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insert(Map<String, dynamic> caregoryMap) async {
    try {
      await _database.insert(
        tableName,
        caregoryMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(Map<String, dynamic> caregoryMap) async {
    try {
      await _database.update(
        tableName,
        caregoryMap,
        where: "id = ?",
        whereArgs: [caregoryMap["id"]],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(int id) async {
    try {
      await _database.delete(
        tableName,
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (e) {
      rethrow;
    }
  }
}
