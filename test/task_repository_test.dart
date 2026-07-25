import 'package:test/test.dart';
import '../lib/repository/task_repository.dart';
import '../lib/models/task.dart';
import '../lib/models/priority_enum.dart';

void main() {
  late TaskRepository repo;
  late Task task;

  setUp(() {
    repo = TaskRepository();
    task = Task(
      title: "Réviser Dart",
      priority: Priority.medium,
      deadline: DateTime.now(),
    );
  });

  group('TaskRepository', () {
    test('Ajouter une tâche dans le repository', () {
      repo.add(task);

      expect(repo.getAll().length, 1);
    });

    test('Retirer une tâche du repository', () {
      repo.add(task);

      repo.remove(task);

      expect(repo.getAll().length, 0);
    });

    test('Mettre à jour une tâche existante', () {
      repo.add(task);
      final updated = task.copyWith(title: "Réviser Flutter");

      repo.update(task, updated);

      expect(repo.getAll().first.title, "Réviser Flutter");
    });

    test('getAll() renvoie une liste non modifiable', () {
      repo.add(task);

      expect(() => repo.getAll().add(task), throwsUnsupportedError);
    });
  });
}
