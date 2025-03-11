import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_management/core/utils/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../data/models/task_model.dart';

class TaskCard extends ConsumerWidget {
  final TaskModel task;
  TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.addTask, arguments: task);
      },
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0XFFDCE1EF)),
          borderRadius: BorderRadius.circular(12),
        ),

        margin: EdgeInsets.only(top: 8),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text(
                task.description,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColor.greyText,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.timer_outlined, color: Colors.black, size: 12),
                  SizedBox(width: 6),
                  Text(
                    DateFormat('MMMM dd, yyyy').format(task.endDate),
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColor.greyText,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color:
                            task.isCompleted
                                ? Color(0xFF009F76)
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
