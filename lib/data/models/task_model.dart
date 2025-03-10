import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final DateTime startDate;

  @HiveField(3)
  final DateTime endDate;

  @HiveField(4)
  final bool isCompleted;

  TaskModel({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.isCompleted = false,
  });
}
