import '../lib/models/task.dart';
import '../lib/models/priority_enum.dart';
import '../lib/repository/task_repository.dart';
import '../lib/services/task_service.dart';
import '../lib/exceptions/task_exception.dart';

void main() {
  final repository = TaskRepository();
  final service = TaskService(repository: repository);

  service.addTask(Task(
    title: "Apprendre Dart",
    priority: Priority.high,
    deadline: DateTime(2026, 8, 1),
  ));
  service.addTask(Task(
    title: "Faire les courses",
    priority: Priority.low,
    deadline: DateTime(2026, 7, 28),
  ));

  print("--- Toutes les tâches ---");
  service.getTasks().forEach(print);

  print("\n--- Triées par priorité ---");
  service.sortByPriority().forEach(print);

  print("\n--- Triées par échéance ---");
  service.sortByDeadline().forEach(print);

  print("\n--- Sérialisation JSON ---");
  final json = service.getTasks().first.toJson();
  print(json);
  final rebuilt = Task.fromJson(json);
  print("Reconstruite : $rebuilt");

  print("\n--- Gestion des erreurs ---");
  try {
    service.addTask(Task(
      title: "Apprendre Dart",
      priority: Priority.medium,
      deadline: DateTime.now(),
    ));
  } on TaskException catch (e) {
    print("Erreur attendue capturée : $e");
  }

  try {
    service.findTaskByTitle("Tâche qui n'existe pas");
  } on TaskException catch (e) {
    print("Erreur attendue capturée : $e");
  }
}
