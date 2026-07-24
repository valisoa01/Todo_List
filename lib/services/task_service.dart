// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../models/task.dart';
import '../repository/task_repository.dart';

class TaskService {
  final TaskRepository _repository;
  TaskService({
    required this._repository,
  });
  void addTask (Task task) {
    _repository.add(task);
  }
  List<Task> getTastks() {
    return _repository.getAll();
  }
  void removeTask(Task task) {
    _repository.remove(task);
  }
  void updateTask (oldTask, Task newTask) {
    _repository.update(oldTask, newTask);
  }
}
