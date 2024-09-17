import 'package:bloc/bloc.dart';
import 'package:imtihon/bloc/category/category_event.dart';
import 'package:imtihon/bloc/category/category_state.dart';
import 'package:imtihon/modules/home/data/models/category.dart';
import 'package:imtihon/modules/home/data/repository/categories_repository.dart';

class CategoryBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository _categoriesRepository;
  CategoryBloc(CategoriesRepository categoriesRepository)
      : _categoriesRepository = categoriesRepository,
        super(InitialCategoriesState()) {
    on<GetCategoriesEvent>(getCategories);
    on<InsertCategoryEvent>(insertCategory);
    on<UpdateCategoryEvent>(updateCategory);
    on<DeleteCategoryEvent>(deleteCategory);
  }

  void getCategories(
      GetCategoriesEvent event, Emitter<CategoriesState> emit) async {
    try {
      emit(LoadingCategoriesState());
      final List<CategoryModel>? categories =
          await _categoriesRepository.getCategories();
      emit(LoadedCategoriesState(categories: categories));
    } catch (e) {
      ErrorCategoriesState(message: e.toString());
    }
  }

  void insertCategory(
      InsertCategoryEvent event, Emitter<CategoriesState> emit) async {
    try {
      emit(LoadingCategoriesState());
      await _categoriesRepository.insert(event.categoryMap);
      final List<CategoryModel>? categories =
          await _categoriesRepository.getCategories();
      emit(LoadedCategoriesState(categories: categories));
    } catch (e) {
      ErrorCategoriesState(message: e.toString());
    }
  }

  void updateCategory(
      UpdateCategoryEvent event, Emitter<CategoriesState> emit) async {
    try {
      emit(LoadingCategoriesState());
      await _categoriesRepository.update(event.categoryMap);
      final List<CategoryModel>? categories =
          await _categoriesRepository.getCategories();
      emit(LoadedCategoriesState(categories: categories));
    } catch (e) {
      ErrorCategoriesState(message: e.toString());
    }
  }

  void deleteCategory(
      DeleteCategoryEvent event, Emitter<CategoriesState> emit) async {
    try {
      emit(LoadingCategoriesState());
      await _categoriesRepository.delete(event.id);
      final List<CategoryModel>? categories =
          await _categoriesRepository.getCategories();
      emit(LoadedCategoriesState(categories: categories));
    } catch (e) {
      ErrorCategoriesState(message: e.toString());
    }
  }
}
