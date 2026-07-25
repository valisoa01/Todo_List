import 'dart:io';

import '../models/task.dart';
import '../../utils/json_helper.dart';

class StorageService {
  final String filePath;

  StorageService({this.filePath = 'data/task.json'});

  List<Task> loadTasks() {
    final file = File(filePath);
    if (!file.existsSync()) {
      return [];
    }

    final content = file.readAsStringSync().trim();
    if (content.isEmpty) {
      return [];
    }

    final decoded = JsonHelper.decode(content) as List<dynamic>;
    return decoded
        .map((item) => Task.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  void saveTasks(List<Task> tasks) {
    final file = File(filePath);
    file.createSync(recursive: true);

    final jsonList = tasks.map((t) => t.toJson()).toList();
    file.writeAsStringSync(JsonHelper.encode(jsonList));
  }
}
