import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon/bloc/category/category_bloc.dart';
import 'package:imtihon/bloc/category/category_event.dart';
import 'package:imtihon/bloc/category/category_state.dart';
import 'package:imtihon/bloc/expense/expense_bloc.dart';
import 'package:imtihon/bloc/expense/expense_event.dart';
import 'package:imtihon/modules/home/data/models/category.dart';

import 'package:imtihon/modules/home/presentation/widgets/category_manage_dialog.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    context.read<CategoryBloc>().add(GetCategoriesEvent());
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
            builder: (ctx) => const CategoryManageDialog(),
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
      body: BlocBuilder<CategoryBloc, CategoriesState>(
        builder: (context, state) {
          if (state is InitialCategoriesState) {
            return const Center(
              child: Text("Boshlang'ich holatda"),
            );
          }
          if (state is LoadingCategoriesState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is ErrorCategoriesState) {
            return Center(
              child: Text("Xatolik: ${state.message}"),
            );
          }
          List<CategoryModel>? categories =
              (state as LoadedCategoriesState).categories;
          if (categories == null) {
            return const Center(
              child: Text("Not found Expenses"),
            );
          }

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              CategoryModel category = categories[index];
              return GestureDetector(
                child: ListTile(
                  title: Text(category.name),
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
                          builder: (ctx) => CategoryManageDialog(
                            expense: category,
                          ),
                        );
                        data["id"] = "${category.id}";
                        // ignore: use_build_context_synchronously
                        context.read<CategoryBloc>().add(
                              UpdateCategoryEvent(categoryMap: data),
                            );
                      } else if (value == 1) {
                        context
                            .read<CategoryBloc>()
                            .add(DeleteCategoryEvent(id: category.id));
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
