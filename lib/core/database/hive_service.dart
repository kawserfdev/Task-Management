import 'package:hive/hive.dart';
import '../../data/models/task_model.dart';

class HiveService {
  final Box<TaskModel> _box = Hive.box<TaskModel>("tasksbox");

  Future<void> addTask(TaskModel task) async {
    await _box.add(task);
  }

  Future<List<TaskModel>> getTasks() async {
    return _box.values.toList();
  }

  Future<void> updateTask(int index, TaskModel task) async {
    await _box.putAt(index, task);
  }
}
