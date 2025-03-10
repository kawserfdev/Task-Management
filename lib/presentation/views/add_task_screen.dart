import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management/presentation/widgets/summary_card.dart';
import '../viewmodels/task_viewmodel.dart';
import '../../data/models/task_model.dart';

class AddTaskScreen extends ConsumerWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskViewModel = ref.read(taskViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Create new task")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: "Task Name")),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: "Task Description")),
            SizedBox(height: 20),
            CustomButton(
              text: "Create new tasks",
              onPressed: () {
                TaskModel newTask = TaskModel(
                  title: titleController.text,
                  description: descriptionController.text,
                  startDate: DateTime.now(),
                  endDate: DateTime.now().add(Duration(days: 1)),
                );
                taskViewModel.addTask(newTask);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
