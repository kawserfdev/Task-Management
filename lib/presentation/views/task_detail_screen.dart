import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  final Map<String, dynamic> task;

  TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task['title'] ?? 'Task Detail')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Task Title:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(task['title'], style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text("Description:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(task['description'], style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            Text("Due Date:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(task['dueDate'] ?? 'No Due Date', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
