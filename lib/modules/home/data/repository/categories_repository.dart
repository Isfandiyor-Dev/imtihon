import 'package:imtihon/core/network/db_category_service.dart';
import 'package:imtihon/modules/home/data/models/category.dart';
import 'package:sqflite/sqlite_api.dart';

class CategoriesRepository {
  late DbCategoryService dbService;
  CategoriesRepository(this.dbService);

  Future<List<CategoryModel>?> getCategories() async {
    try {
      final data = await dbService.getCategories();
      return data.map((e) => CategoryModel.fromMap(e)).toList();
    } on DatabaseException catch (e) {
      print("${e.result}");
      rethrow;
    } catch (e) {
      print("$e");
      rethrow;
    }
  }

  Future<void> insert(Map<String, dynamic> caregoryMap) async {
    try {
      await dbService.insert(caregoryMap);
    } on DatabaseException catch (e) {
      print("$e");
      rethrow;
    } catch (e) {
      print("$e");
      rethrow;
    }
  }

  Future<void> update(Map<String, dynamic> caregoryMap) async {
    try {
      await dbService.update(caregoryMap);
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
