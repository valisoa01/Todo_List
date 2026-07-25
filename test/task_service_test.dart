import 'package:test/test.dart';
import '../lib/services/task_service.dart';
import '../lib/repository/task_repository.dart';
import '../lib/models/task.dart';
import '../lib/models/priority_enum.dart';
import '../lib/exceptions/duplicate_task_exception.dart';
import '../lib/exceptions/invalid_task_exception.dart';
import '../lib/exceptions/task_not_found_exception.dart';

void main() {
  late TaskService service;

  setUp(() {
    service = TaskService(repository: TaskRepository());
  });

  Task buildTask(String title, {Priority priority = Priority.medium, DateTime? deadline}) {
    return Task(
      title: title,
      priority: priority,
      deadline: deadline ?? DateTime.now(),
    );
  }

  group('addTask', () {
    test('ajoute une tâche valide', () {
      final task = buildTask("Faire les courses");

      service.addTask(task);

      expect(service.getTasks(), contains(task));
    });

    test('refuse un titre vide', () {
      final task = buildTask("   ");

      expect(() => service.addTask(task), throwsA(isA<InvalidTaskException>()));
    });

    test('refuse un doublon (insensible à la casse)', () {
      service.addTask(buildTask("Lire"));

      expect(
        () => service.addTask(buildTask("lire")),
        throwsA(isA<DuplicateTaskException>()),
      );
    });
  });

  group('removeTask', () {
    test('retire une tâche existante', () {
      final task = buildTask("Nettoyer");
      service.addTask(task);

      service.removeTask(task);

      expect(service.getTasks(), isEmpty);
    });

    test('lève une exception si la tâche est introuvable', () {
      final task = buildTask("Fantôme");

      expect(() => service.removeTask(task), throwsA(isA<TaskNotFoundException>()));
    });
  });

  group('updateTask', () {
    test('met à jour une tâche existante', () {
      final task = buildTask("Ancien titre");
      service.addTask(task);
      final newTask = task.copyWith(title: "Nouveau titre");

      service.updateTask(task, newTask);

      expect(service.getTasks().first.title, "Nouveau titre");
    });

    test('lève une exception si la tâche à modifier est introuvable', () {
      final task = buildTask("Inexistante");
      final newTask = task.copyWith(title: "Peu importe");

      expect(() => service.updateTask(task, newTask), throwsA(isA<TaskNotFoundException>()));
    });

    test('lève une exception si le nouveau titre est vide', () {
      final task = buildTask("Valide");
      service.addTask(task);
      final newTask = task.copyWith(title: "   ");

      expect(() => service.updateTask(task, newTask), throwsA(isA<InvalidTaskException>()));
    });
  });

  group('findTaskByTitle', () {
    test('trouve une tâche par titre (insensible à la casse)', () {
      final task = buildTask("Payer les factures");
      service.addTask(task);

      final found = service.findTaskByTitle("payer les factures");

      expect(found, task);
    });

    test('lève une exception si aucune tâche ne correspond', () {
      expect(
        () => service.findTaskByTitle("N'existe pas"),
        throwsA(isA<TaskNotFoundException>()),
      );
    });
  });

  group('tri', () {
    test('sortByPriority trie de high à low', () {
      service.addTask(buildTask("Basse", priority: Priority.low));
      service.addTask(buildTask("Haute", priority: Priority.high));
      service.addTask(buildTask("Moyenne", priority: Priority.medium));

      final sorted = service.sortByPriority();

      expect(sorted.map((t) => t.priority).toList(), [
        Priority.high,
        Priority.medium,
        Priority.low,
      ]);
    });

    test('sortByDeadline trie du plus proche au plus lointain', () {
      final now = DateTime.now();
      service.addTask(buildTask("Plus tard", deadline: now.add(const Duration(days: 5))));
      service.addTask(buildTask("Bientôt", deadline: now.add(const Duration(days: 1))));

      final sorted = service.sortByDeadline();

      expect(sorted.first.title, "Bientôt");
      expect(sorted.last.title, "Plus tard");
    });
  });
}
