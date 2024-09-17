import 'package:imtihon/modules/home/data/models/expense.dart';

sealed class ExpensesState {}

final class InitialExpensesState extends ExpensesState {}

final class LoadingExpensesState extends ExpensesState {}

final class LoadedExpensesState extends ExpensesState {
  final List<Expense>? expenses;
  LoadedExpensesState({required this.expenses});
}

final class ErrorExpensesState extends ExpensesState {
  final String message;
  ErrorExpensesState({required this.message});
}
