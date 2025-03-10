import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.initialRoute,
    );
  }
}
