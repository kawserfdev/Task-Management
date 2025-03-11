import 'package:hive/hive.dart';
import 'package:task_management/data/models/task_model.dart';

class HiveService {
  final Box<TaskModel> _box = Hive.box<TaskModel>("tasksbox");

  Future<void> addTask(TaskModel task) async {
    await _box.put(task.id, task); 
  }

  Future<List<TaskModel>> getTasks() async {
    return _box.values.toList();
  }

  Future<void> updateTask(String id, TaskModel task) async {
    if (_box.containsKey(id)) {
      await _box.put(id, task);
    }
  }

  Future<void> deleteTask(String id) async {
    if (_box.containsKey(id)) {
      await _box.delete(id);
    }
  }
}
