class CategoriesEvent {}


class GetCategoriesEvent extends CategoriesEvent {}

class InsertCategoryEvent extends CategoriesEvent{
   final Map<String,dynamic> categoryMap;
   InsertCategoryEvent({required this.categoryMap});
}

class UpdateCategoryEvent extends CategoriesEvent {
  final Map<String, dynamic> categoryMap;
  UpdateCategoryEvent({required this.categoryMap});
}

class DeleteCategoryEvent extends CategoriesEvent {
  final int id;
  DeleteCategoryEvent({required this.id});
}
