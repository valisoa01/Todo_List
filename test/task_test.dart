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

    test('toJson / fromJson conservent les mêmes données', () {
      final deadline = DateTime(2026, 8, 1);
      final task = Task(
        title: "Apprendre Dart",
        priority: Priority.high,
        deadline: deadline,
      );

      final json = task.toJson();
      final restored = Task.fromJson(json);

      expect(restored.title, task.title);
      expect(restored.priority, task.priority);
      expect(restored.deadline, task.deadline);
    });
  });
}
