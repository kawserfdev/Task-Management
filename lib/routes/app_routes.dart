import 'package:flutter/material.dart';
import 'package:task_management/app.dart';
import '../presentation/views/home_screen.dart';
import '../presentation/views/add_task_screen.dart';
import '../presentation/views/calendar_screen.dart';
import '../presentation/views/task_detail_screen.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String home = '/home';
  static const String addTask = '/add-task';
  static const String calendar = '/calendar';
  static const String taskDetail = '/task-detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case addTask:
        return MaterialPageRoute(builder: (_) => AddTaskScreen());
      case calendar:
        return MaterialPageRoute(builder: (_) => CalendarScreen());
      case taskDetail:
        final task = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task));
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text("Page Not Found"))));
    }
  }
}
