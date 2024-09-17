import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon/bloc/category/category_bloc.dart';
import 'package:imtihon/bloc/expense/expense_bloc.dart';
import 'package:imtihon/core/network/db_category_service.dart';
import 'package:imtihon/core/network/db_expense_service.dart';
import 'package:imtihon/modules/home/data/repository/categories_repository.dart';
import 'package:imtihon/modules/home/data/repository/expenses_repository.dart';
import 'package:imtihon/modules/home/presentation/screens/categories_screen.dart';
import 'package:imtihon/modules/home/presentation/screens/expenses_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DbExpenseService dbService = DbExpenseService();
  DbCategoryService categoryDbService = DbCategoryService();
  await dbService.init();
  await categoryDbService.init();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ExpensesRepository(dbService),
        ),
        RepositoryProvider(
          create: (context) => CategoriesRepository(categoryDbService),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ExpenseBloc(context.read<ExpensesRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                CategoryBloc(context.read<CategoriesRepository>()),
          )
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const ExpensesScreen(),
    );
  }
}
