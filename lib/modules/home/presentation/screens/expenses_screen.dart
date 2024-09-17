import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon/bloc/expense/expense_bloc.dart';
import 'package:imtihon/bloc/expense/expense_event.dart';
import 'package:imtihon/bloc/expense/expense_state.dart';
import 'package:imtihon/modules/home/data/models/expense.dart';
import 'package:imtihon/modules/home/presentation/widgets/expense_manage_dialog.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  void initState() {
    context.read<ExpenseBloc>().add(GetExpensesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryFixedDim,
      appBar: AppBar(
        title: const Text("Expenses"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = await showDialog(
            context: context,
            builder: (ctx) => ExpenseManageDialog(),
          );
          // ignore: use_build_context_synchronously
          context.read<ExpenseBloc>().add(
                InsertExpenesEvent(
                  expenseMap: data,
                ),
              );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ExpenseBloc, ExpensesState>(
        builder: (context, state) {
          if (state is InitialExpensesState) {
            return const Center(
              child: Text("Boshlang'ich holatda"),
            );
          }
          if (state is LoadingExpensesState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is ErrorExpensesState) {
            return Center(
              child: Text("Xatolik: ${state.message}"),
            );
          }
          List<Expense>? expenses = (state as LoadedExpensesState).expenses;
          if (expenses == null) {
            return const Center(
              child: Text("Not found Expenses"),
            );
          }

          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              Expense expense = expenses[index];
              return ListTile(
                title: Text(expense.description),
                subtitle: Row(
                  children: [
                    Text(expense.summa.toString()),
                    Text(expense.dateTime.toString()),
                  ],
                ),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 0,
                      child: Text("Edit"),
                    ),
                    const PopupMenuItem(
                      value: 1,
                      child: Text("Delete"),
                    ),
                  ],
                  onSelected: (value) async {
                    if (value == 0) {
                      final data = await showDialog(
                        context: context,
                        builder: (ctx) => ExpenseManageDialog(expense: expense),
                      );
                      data["id"] = "${expense.id}";
                      // ignore: use_build_context_synchronously
                      context.read<ExpenseBloc>().add(
                            UpdateExpenseEvent(expenseMap: data),
                          );
                    } else if (value == 1) {
                      context
                          .read<ExpenseBloc>()
                          .add(DeleteExpenseEvent(id: expense.id));
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
