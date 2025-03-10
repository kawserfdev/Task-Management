import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../data/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task; // Changed from Map<String, dynamic>

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.taskDetail, arguments: {
          'title': task.title,
          'description': task.description,
          'status': task.isCompleted ? "Completed" : "Pending",
        });
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 8),
              Text(task.description, style: TextStyle(fontSize: 14, color: Colors.grey)),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.bottomRight,
                child: Chip(
                  label: Text(task.isCompleted ? "Completed" : "Pending"),
                  backgroundColor: task.isCompleted ? Colors.green : Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
