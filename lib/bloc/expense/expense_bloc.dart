import 'package:bloc/bloc.dart';
import 'package:imtihon/bloc/expense/expense_event.dart';
import 'package:imtihon/bloc/expense/expense_state.dart';
import 'package:imtihon/modules/home/data/models/expense.dart';
import 'package:imtihon/modules/home/data/repository/expenses_repository.dart';

class ExpenseBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final ExpensesRepository _expensesRepository;
  ExpenseBloc(ExpensesRepository expenseRepository)
      : _expensesRepository = expenseRepository,
        super(InitialExpensesState()) {
    on<GetExpensesEvent>(getExpenses);
    on<InsertExpenesEvent>(insertExpense);
    on<UpdateExpenseEvent>(updateExpense);
    on<DeleteExpenseEvent>(deleteExpense);
  }

  void getExpenses(GetExpensesEvent event, Emitter<ExpensesState> emit) async {
    try {
      emit(LoadingExpensesState());
      final List<Expense>? expenses = await _expensesRepository.getExpenses();
      emit(LoadedExpensesState(expenses: expenses));
    } catch (e) {
      ErrorExpensesState(message: e.toString());
    }
  }

  void insertExpense(
      InsertExpenesEvent event, Emitter<ExpensesState> emit) async {
    try {
      emit(LoadingExpensesState());
      await _expensesRepository.insert(event.expenseMap);
      final List<Expense>? expenses = await _expensesRepository.getExpenses();
      emit(LoadedExpensesState(expenses: expenses));
    } catch (e) {
      ErrorExpensesState(message: e.toString());
    }
  }

  void updateExpense(
      UpdateExpenseEvent event, Emitter<ExpensesState> emit) async {
    try {
      emit(LoadingExpensesState());
      await _expensesRepository.update(event.expenseMap);
      final List<Expense>? expenses = await _expensesRepository.getExpenses();
      emit(LoadedExpensesState(expenses: expenses));
    } catch (e) {
      ErrorExpensesState(message: e.toString());
    }
  }

  void deleteExpense(
      DeleteExpenseEvent event, Emitter<ExpensesState> emit) async {
    try {
      emit(LoadingExpensesState());
      await _expensesRepository.delete(event.id);
      final List<Expense>? expenses = await _expensesRepository.getExpenses();
      emit(LoadedExpensesState(expenses: expenses));
    } catch (e) {
      ErrorExpensesState(message: e.toString());
    }
  }
}
