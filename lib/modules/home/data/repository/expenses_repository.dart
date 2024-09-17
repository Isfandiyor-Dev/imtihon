import 'package:imtihon/core/network/db_expense_service.dart';
import 'package:imtihon/modules/home/data/models/expense.dart';
import 'package:sqflite/sqlite_api.dart';

class ExpensesRepository {
  late DbExpenseService dbService;
  ExpensesRepository(this.dbService);

  Future<List<Expense>?> getExpenses() async {
    try {
      final data = await dbService.getExpenses();
      return data.map((e) => Expense.fromMap(e)).toList();
    } on DatabaseException catch (e) {
      print("${e.result}");
      rethrow;
    } catch (e) {
      print("$e");
      rethrow;
    }
  }

  Future<void> insert(Map<String, dynamic> expenseMap) async {
    try {
      await dbService.insert(expenseMap);
    } on DatabaseException catch (e) {
      print("$e");
      rethrow;
    } catch (e) {
      print("$e");
      rethrow;
    }
  }

  Future<void> update(Map<String, dynamic> expenseMap) async {
    try {
      await dbService.update(expenseMap);
    } on DatabaseException catch (e) {
      print("$e");
      rethrow;
    } catch (e) {
      print("$e");
      rethrow;
    }
  }

  Future<void> delete(int id) async {
    try {
      final data = await dbService.delete(id);
    } on DatabaseException catch (e) {
      print("$e");
      rethrow;
    } catch (e) {
      print("$e");
      rethrow;
    }
  }
}
