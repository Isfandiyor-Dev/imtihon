import 'package:flutter/material.dart';
import 'package:imtihon/modules/home/data/models/category.dart';

class CategoryManageDialog extends StatefulWidget {
  final CategoryModel? expense;
  const CategoryManageDialog({super.key, this.expense});

  @override
  State<CategoryManageDialog> createState() => _CategoryManageDialogState();
}

class _CategoryManageDialogState extends State<CategoryManageDialog> {
  late bool isAddDialog;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    isAddDialog = widget.expense == null;
    nameController = TextEditingController(
      text: isAddDialog ? null : widget.expense!.name.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(isAddDialog ? "Add Dialog" : "Edit Dialog"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Name"),
                hintText: "Enter name",
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, {
              "name": nameController.text,
            });
          },
          child: Text(isAddDialog ? "Add" : "Save"),
        ),
      ],
    );
  }
}
