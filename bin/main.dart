import 'dart:io';

import '../lib/models/task.dart';
import '../lib/models/urgent_task.dart';
import '../lib/models/priority_enum.dart';
import '../lib/repository/task_repository.dart';
import '../lib/services/task_service.dart';
import '../lib/services/storage_service.dart';
import '../lib/exceptions/task_exception.dart';

void main() {
  final repository = TaskRepository();
  final storage = StorageService(filePath: 'data/task.json');
  final service = TaskService(repository: repository, storage: storage);

  print("==============================");
  print("      GESTIONNAIRE DE TÂCHES");
  print("==============================");

  var running = true;
  while (running) {
    _printMenu();
    stdout.write("Choix : ");
    final choice = stdin.readLineSync()?.trim();

    try {
      switch (choice) {
        case "1":
          _addTaskFlow(service);
          break;
        case "2":
          _printTasks(service.getTasks());
          break;
        case "3":
          _completeTaskFlow(service);
          break;
        case "4":
          _deleteTaskFlow(service);
          break;
        case "5":
          _searchTaskFlow(service);
          break;
        case "6":
          _printTasks(service.sortByPriority());
          break;
        case "7":
          _printTasks(service.sortByDeadline());
          break;
        case "8":
          running = false;
          print("À bientôt !");
          break;
        default:
          print("Choix invalide.");
      }
    } on TaskException catch (e) {
      print("Erreur : $e");
    }
  }
}

void _printMenu() {
  print("\n1. Ajouter une tâche");
  print("2. Afficher les tâches");
  print("3. Marquer une tâche comme terminée");
  print("4. Supprimer une tâche");
  print("5. Rechercher une tâche par titre");
  print("6. Trier par priorité");
  print("7. Trier par échéance");
  print("8. Quitter");
}

void _printTasks(List<Task> tasks) {
  if (tasks.isEmpty) {
    print("Aucune tâche.");
    return;
  }
  for (var i = 0; i < tasks.length; i++) {
    print("${i + 1}. ${tasks[i]}");
  }
}

Priority _readPriority() {
  stdout.write("Priorité (low/medium/high) : ");
  final input = stdin.readLineSync()?.trim().toLowerCase();
  return Priority.values.firstWhere(
    (p) => p.name == input,
    orElse: () => Priority.medium,
  );
}

DateTime? _readDeadline() {
  stdout.write("Date limite (AAAA-MM-JJ, laisser vide si aucune) : ");
  final input = stdin.readLineSync()?.trim();
  if (input == null || input.isEmpty) return null;
  return DateTime.tryParse(input);
}

void _addTaskFlow(TaskService service) {
  stdout.write("Titre : ");
  final title = stdin.readLineSync() ?? "";
  final priority = _readPriority();
  final deadline = _readDeadline();

  stdout.write("Tâche urgente ? (o/n) : ");
  final isUrgent = stdin.readLineSync()?.trim().toLowerCase() == "o";

  if (isUrgent) {
    stdout.write("Message d'alerte : ");
    final alertMessage = stdin.readLineSync() ?? "";
    service.addTask(UrgentTask(
      title: title,
      priority: priority,
      deadline: deadline ?? DateTime.now(),
      alertMessage: alertMessage,
    ));
  } else {
    service.addTask(
      Task(title: title, priority: priority, deadline: deadline),
    );
  }
  print("Tâche ajoutée.");
}

void _completeTaskFlow(TaskService service) {
  stdout.write("Titre de la tâche à terminer : ");
  final title = stdin.readLineSync() ?? "";
  final task = service.findTaskByTitle(title);
  service.completeTask(task);
  print("Tâche marquée comme terminée.");
}

void _deleteTaskFlow(TaskService service) {
  stdout.write("Titre de la tâche à supprimer : ");
  final title = stdin.readLineSync() ?? "";
  final task = service.findTaskByTitle(title);
  service.removeTask(task);
  print("Tâche supprimée.");
}

void _searchTaskFlow(TaskService service) {
  stdout.write("Titre à rechercher : ");
  final title = stdin.readLineSync() ?? "";
  final task = service.findTaskByTitle(title);
  print(task);
}
