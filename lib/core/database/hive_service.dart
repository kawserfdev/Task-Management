import 'package:hive/hive.dart';
import '../../data/models/task_model.dart';

class HiveService {
  static const String _boxName = "tasksBox";

  Future<void> addTask(TaskModel task) async {
    final box = await Hive.openBox<TaskModel>(_boxName);
    await box.add(task);
  }

  Future<List<TaskModel>> getTasks() async {
    final box = await Hive.openBox<TaskModel>(_boxName);
    return box.values.toList();
  }

  Future<void> updateTask(int index, TaskModel task) async {
    final box = await Hive.openBox<TaskModel>(_boxName);
    await box.putAt(index, task);
  }
}
