import 'package:task_management/core/database/hive_service.dart';
import 'package:task_management/data/models/task_model.dart';

class TaskRepositoryImpl {
  final HiveService hiveService;

  TaskRepositoryImpl({required this.hiveService});

  Future<void> addTask(TaskModel task) async {
    await hiveService.addTask(task);
  }

  Future<List<TaskModel>> getTasks() async {
    return await hiveService.getTasks();
  }

  Future<void> updateTask(String id, TaskModel task) async {
    await hiveService.updateTask(id, task);
  }

  Future<void> deleteTask(String id) async {
    await hiveService.deleteTask(id);
  }
}
