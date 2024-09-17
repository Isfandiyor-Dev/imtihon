import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbExpenseService {
  late Database _database;
  String tableName = "expenses";

  DbExpenseService._internal();

  static final DbExpenseService _instanse = DbExpenseService._internal();

  factory DbExpenseService() => _instanse;

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
      summa REAL,
      dateTime TEXT,
      category TEXT,
      description TEXT
    )
""";
    db.execute(query);
  }

  Future<List<Map<String, Object?>>> getExpenses() async {
    try {
      final data = await _database.query(tableName);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insert(Map<String, dynamic> expenseMap) async {
    try {
      await _database.insert(
        tableName,
        expenseMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(Map<String, dynamic> expenseMap) async {
    try {
      await _database.update(
        tableName,
        expenseMap,
        where: "id = ?",
        whereArgs: [expenseMap["id"]],
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
