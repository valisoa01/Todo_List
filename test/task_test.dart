import 'package:test/test.dart';
import '../lib/models/task.dart';
import '../lib/models/priority_enum.dart';

void main() {
  group('Task', () {
    test('copyWith modifie uniquement le titre', () {
      final task = Task(
        title: "Math",
        priority: Priority.low,
        deadline: DateTime.now(),
      );

      final newTask = task.copyWith(title: "Flutter");

      expect(newTask.title, "Flutter");
      expect(newTask.priority, Priority.low);
    });

    test('le setter title ignore une valeur vide ou blanche', () {
      final task = Task(
        title: "Math",
        priority: Priority.low,
        deadline: DateTime.now(),
      );

      task.title = "   ";

      expect(task.title, "Math");
    });

    test('une tâche est créée non terminée par défaut', () {
      final task = Task(title: "Lire", priority: Priority.low);

      expect(task.completed, false);
    });

    test('copyWith peut marquer une tâche comme terminée', () {
      final task = Task(title: "Lire", priority: Priority.low);

      final done = task.copyWith(completed: true);

      expect(done.completed, true);
      expect(task.completed, false); // l'original n'est pas modifié
    });

    test('la date limite est optionnelle', () {
      final task = Task(title: "Sans échéance", priority: Priority.medium);

      expect(task.deadline, isNull);
    });

    test('toJson / fromJson conservent les mêmes données (avec échéance)', () {
      final deadline = DateTime(2026, 8, 1);
      final task = Task(
        title: "Apprendre Dart",
        priority: Priority.high,
        deadline: deadline,
        completed: true,
      );

      final json = task.toJson();
      final restored = Task.fromJson(json);

      expect(restored.title, task.title);
      expect(restored.priority, task.priority);
      expect(restored.deadline, task.deadline);
      expect(restored.completed, true);
    });

    test('toJson / fromJson gèrent une échéance nulle', () {
      final task = Task(title: "Sans échéance", priority: Priority.low);

      final json = task.toJson();
      expect(json["deadline"], isNull);

      final restored = Task.fromJson(json);
      expect(restored.deadline, isNull);
    });
  });
}
