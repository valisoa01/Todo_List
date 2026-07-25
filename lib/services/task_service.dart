import '../exceptions/duplicate_task_exception.dart';
import '../exceptions/invalid_task_exception.dart';
import '../exceptions/task_not_found_exception.dart';
import '../models/task.dart';
import '../repository/task_repository.dart';

class TaskService {
  final TaskRepository _repository;

  TaskService({
    required TaskRepository repository,
  }) : _repository = repository;
  
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
}

  void removeTask(Task task) {
    if(!_repository.getAll().contains(task)) {
      throw TaskNotFoundException("La tâche n'existe pas.");
    }
    _repository.remove(task);
  }

  void updateTask(Task oldTask, Task newTask) {
    if (!_repository.getAll().contains(oldTask)) {
      throw TaskNotFoundException("La tâche à modifier est introuvable.");
    }
    if (newTask.title.trim().isEmpty) {
      throw InvalidTaskException("Le titre de la nouvelle tâche est vide.");
    }
    _repository.update(oldTask, newTask);
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

  tasks.sort(
    (a, b) => a.deadline.compareTo(b.deadline),
  );

  return tasks;
}
}