class ExpensesEvent {}


class GetExpensesEvent extends ExpensesEvent {}

class InsertExpenesEvent extends ExpensesEvent{
   final Map<String,dynamic> expenseMap;
   InsertExpenesEvent({required this.expenseMap});
}

class UpdateExpenseEvent extends ExpensesEvent {
  final Map<String, dynamic> expenseMap;
  UpdateExpenseEvent({required this.expenseMap});
}

class DeleteExpenseEvent extends ExpensesEvent {
  final int id;
  DeleteExpenseEvent({required this.id});
}
