import '../../core/database/hive_service.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl {
  final HiveService hiveService;

  TaskRepositoryImpl({required this.hiveService});

  Future<void> addTask(TaskModel task) async {
    await hiveService.addTask(task);
  }

  Future<List<TaskModel>> getTasks() async {
    return await hiveService.getTasks();
  }
}
