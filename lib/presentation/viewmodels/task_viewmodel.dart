import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../core/database/hive_service.dart';

final taskViewModelProvider = ChangeNotifierProvider((ref) {
  return TaskViewModel(TaskRepositoryImpl(hiveService: HiveService()));
});

class TaskViewModel extends ChangeNotifier {
  final TaskRepositoryImpl taskRepository;
  List<TaskModel> _tasks = [];
  bool _isLoading = true;

  TaskViewModel(this.taskRepository) {
    loadTasks();
  }

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;

  Future<void> addTask(TaskModel task) async {
    await taskRepository.addTask(task);
    await loadTasks();
  }

  Future<void> updateTask(String id, TaskModel updatedTask) async {
    await taskRepository.updateTask(id, updatedTask);
    await loadTasks(); 
  }

  Future<void> deleteTask(String id) async {
    await taskRepository.deleteTask(id);
    await loadTasks();
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();
    try {
      _tasks = await taskRepository.getTasks();
    } catch (e) {
      debugPrint("Error loading tasks: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
