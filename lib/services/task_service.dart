import '../models/task.dart';
import '../repository/task_repository.dart';

class TaskService {
  final TaskRepository _repository;

  TaskService({
    required TaskRepository repository,
  }) : _repository = repository;

  void addTask(Task task) {
    _repository.add(task);
  }

  List<Task> getTasks() {
    return _repository.getAll();
  }

  void removeTask(Task task) {
    _repository.remove(task);
  }

  void updateTask(Task oldTask, Task newTask) {
    _repository.update(oldTask, newTask);
  }
}