import 'dart:io';

import 'package:test/test.dart';
import '../lib/models/task.dart';
import '../lib/models/priority_enum.dart';
import '../lib/services/storage_service.dart';

void main() {
  late Directory tempDir;
  late String filePath;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('todo_list_test_');
    filePath = '${tempDir.path}/tasks_test.json';
  });

  tearDown(() {
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('StorageService', () {
    test('loadTasks renvoie une liste vide si le fichier n\'existe pas', () {
      final storage = StorageService(filePath: filePath);

      expect(storage.loadTasks(), isEmpty);
    });

    test('saveTasks puis loadTasks restituent les mêmes tâches', () {
      final storage = StorageService(filePath: filePath);
      final tasks = [
        Task(title: "Tâche A", priority: Priority.high, deadline: DateTime(2026, 1, 1)),
        Task(title: "Tâche B", priority: Priority.low),
      ];

      storage.saveTasks(tasks);
      final loaded = storage.loadTasks();

      expect(loaded.length, 2);
      expect(loaded[0].title, "Tâche A");
      expect(loaded[0].deadline, DateTime(2026, 1, 1));
      expect(loaded[1].title, "Tâche B");
      expect(loaded[1].deadline, isNull);
    });

    test('le fichier est bien créé sur le disque', () {
      final storage = StorageService(filePath: filePath);
      storage.saveTasks([Task(title: "X", priority: Priority.medium)]);

      expect(File(filePath).existsSync(), true);
    });
  });
}
