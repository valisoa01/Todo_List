import '../exceptions/duplicate_task_exception.dart';
import '../exceptions/invalid_task_exception.dart';
import '../exceptions/task_not_found_exception.dart';
import '../models/task.dart';
import '../repository/task_repository.dart';
import 'storage_service.dart';

class TaskService {
  final TaskRepository _repository;
  final StorageService? _storage;

  TaskService({
    required TaskRepository repository,
    StorageService? storage,
  })  : _repository = repository,
        _storage = storage {
    _loadFromStorage();
  }

  void _loadFromStorage() {
    final storage = _storage;
    if (storage == null) return;
    for (final task in storage.loadTasks()) {
      _repository.add(task);
    }
  }

  void _persist() {
    _storage?.saveTasks(_repository.getAll());
  }

  List<Task> getTasks() {
    return _repository.getAll();
  }

  void addTask(Task task) {
    if (task.title.trim().isEmpty) {
      throw InvalidTaskException("Le titre de la tâche est vide.");
    }

    final exists = _repository.getAll().any(
          (t) => t.title.toLowerCase() == task.title.toLowerCase(),
        );

    if (exists) {
      throw DuplicateTaskException("Une tâche avec ce titre existe déjà.");
    }

    _repository.add(task);
    _persist();
  }

  void removeTask(Task task) {
    if (!_repository.getAll().contains(task)) {
      throw TaskNotFoundException("La tâche n'existe pas.");
    }
    _repository.remove(task);
    _persist();
  }

  void updateTask(Task oldTask, Task newTask) {
    if (!_repository.getAll().contains(oldTask)) {
      throw TaskNotFoundException("La tâche à modifier est introuvable.");
    }
    if (newTask.title.trim().isEmpty) {
      throw InvalidTaskException("Le titre de la nouvelle tâche est vide.");
    }
    _repository.update(oldTask, newTask);
    _persist();
  }

  void completeTask(Task task) {
    if (!_repository.getAll().contains(task)) {
      throw TaskNotFoundException("La tâche à terminer est introuvable.");
    }
    final updated = task.copyWith(completed: true);
    _repository.update(task, updated);
    _persist();
  }

  List<Task> sortByPriority() {
    final tasks = List<Task>.from(_repository.getAll());
    tasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
    return tasks;
  }

  Task findTaskByTitle(String title) {
    try {
      return _repository.getAll().firstWhere(
            (task) => task.title.toLowerCase() == title.toLowerCase(),
          );
    } catch (_) {
      throw TaskNotFoundException("Aucune tâche trouvée avec ce titre.");
    }
  }

  List<Task> sortByDeadline() {
    final tasks = List<Task>.from(_repository.getAll());

    tasks.sort((a, b) {
      final deadlineA = a.deadline;
      final deadlineB = b.deadline;
      if (deadlineA == null && deadlineB == null) return 0;
      if (deadlineA == null) return 1;
      if (deadlineB == null) return -1;
      return deadlineA.compareTo(deadlineB);
    });

    return tasks;
  }
}
