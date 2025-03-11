import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/core/utils/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../data/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task; // Changed from Map<String, dynamic>

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.taskDetail,
          arguments: {
            'title': task.title,
            'description': task.description,
            'status': task.isCompleted ? "Completed" : "Todo",
          },
        );
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0XFFDCE1EF)),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              SizedBox(height: 4),
              Text(
                task.description,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0XFF6E7591),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.timer_outlined, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    DateFormat('MMMM dd, yyyy').format(task.endDate),
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Spacer(),
                  Container(
                    height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color:
                          task.isCompleted
                              ? Color(0xFFEEFFE0)
                              : Color(0xFFF0EDFD),
                    ),
                    child: Text(
                      task.isCompleted ? "Completed" : "Todo",
                      style: TextStyle(
                        color:
                            task.isCompleted
                                ? Colors.green
                                : AppColor.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
