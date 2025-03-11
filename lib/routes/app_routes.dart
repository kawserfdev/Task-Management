import 'package:flutter/material.dart';
import 'package:task_management/app.dart';
import 'package:task_management/data/models/task_model.dart';
import '../presentation/views/home_screen.dart';
import '../presentation/views/add_task_screen.dart';
import '../presentation/views/calendar_screen.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String home = '/home';
  static const String addTask = '/add-task';
  static const String calendar = '/calendar';
  static const String taskDetail = '/task-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
         final int index = (settings.arguments as int?) ?? 0;
        return MaterialPageRoute(
          builder: (_) => DashBoardActivity(initialIndex: index),
        );
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case addTask:
        final task = settings.arguments as TaskModel;
        return MaterialPageRoute(builder: (_) => AddTaskScreen(task: task));
      case calendar:
        return MaterialPageRoute(builder: (_) => CalendarScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("Page Not Found"))),
        );
    }
  }
}
