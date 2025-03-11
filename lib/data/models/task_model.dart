import 'package:hive/hive.dart';

part "task_model.g.dart"; // Important: This tells Hive to generate the adapter

@HiveType(typeId: 0)
class TaskModel extends HiveObject { 

  @HiveField(0)
  final String id; // Unique Task ID

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime startDate;

  @HiveField(4)
  final DateTime endDate;

  @HiveField(5)
  final bool isCompleted;

  TaskModel({
    required this.id, 
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.isCompleted = false,
  });

  // CopyWith method
  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
