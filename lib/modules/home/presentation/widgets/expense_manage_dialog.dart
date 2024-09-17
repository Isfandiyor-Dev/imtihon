import 'package:flutter/material.dart';
import 'package:imtihon/modules/home/data/models/expense.dart';

class ExpenseManageDialog extends StatefulWidget {
  final Expense? expense;
  ExpenseManageDialog({super.key, this.expense});

  @override
  State<ExpenseManageDialog> createState() => _ExpenseManageDialogState();
}

class _ExpenseManageDialogState extends State<ExpenseManageDialog> {
  late bool isAddDialog;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController summaController;
  late final TextEditingController dateTimeController;
  late final TextEditingController categoryController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    isAddDialog = widget.expense == null;
    summaController = TextEditingController(
      text: isAddDialog ? null : widget.expense!.summa.toString(),
    );
    dateTimeController = TextEditingController(
      text: isAddDialog ? null : widget.expense!.dateTime.toString(),
    );
    categoryController = TextEditingController(
      text: isAddDialog ? null : widget.expense!.category.toString(),
    );
    descriptionController = TextEditingController(
      text: isAddDialog ? null : widget.expense!.description.toString(),
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
              controller: descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Description"),
                hintText: "Enter description",
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: summaController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Summa"),
                hintText: "Enter expense sum",
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: categoryController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Category"),
                hintText: "Enter category",
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: dateTimeController,
              readOnly: true,
              onTap: () async {
                DateTime? dateTime = DateTime.now();
                dateTime = await showDatePicker(
                  context: context,
                  initialDate:
                      isAddDialog ? dateTime : widget.expense!.dateTime,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (dateTime != null) {
                  dateTimeController.text = dateTime.toIso8601String();
                }
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Date"),
                hintText: "Choose date time",
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
              "summa": summaController.text,
              "dateTime": dateTimeController.text,
              "category": categoryController.text,
              "description": descriptionController.text,
            });
          },
          child: Text(isAddDialog ? "Add" : "Save"),
        ),
      ],
    );
  }
}
