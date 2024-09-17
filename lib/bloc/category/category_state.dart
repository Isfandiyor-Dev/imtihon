
import 'package:imtihon/modules/home/data/models/category.dart';

sealed class CategoriesState {}

final class InitialCategoriesState extends CategoriesState {}

final class LoadingCategoriesState extends CategoriesState {}

final class LoadedCategoriesState extends CategoriesState {
  final List<CategoryModel>? categories;
  LoadedCategoriesState({required this.categories});
}

final class ErrorCategoriesState extends CategoriesState {
  final String message;
  ErrorCategoriesState({required this.message});
}
