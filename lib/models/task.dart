import 'priority_enum.dart';

class Task {
  String _title;
  Priority _priority;
  DateTime? _deadline;
  bool _completed;

  Task({
    required String title,
    required Priority priority,
    DateTime? deadline,
    bool completed = false,
  })  : _title = title,
        _priority = priority,
        _deadline = deadline,
        _completed = completed;

  String get title => _title;
  Priority get priority => _priority;
  DateTime? get deadline => _deadline;
  bool get completed => _completed;

  set title(String value) {
    if (value.trim().isNotEmpty) {
      _title = value;
    }
  }

  set priority(Priority value) {
    _priority = value;
  }

  set deadline(DateTime? value) {
    _deadline = value;
  }

  set completed(bool value) {
    _completed = value;
  }

  Task copyWith({
    String? title,
    Priority? priority,
    DateTime? deadline,
    bool? completed,
  }) {
    return Task(
      title: title ?? _title,
      priority: priority ?? _priority,
      deadline: deadline ?? _deadline,
      completed: completed ?? _completed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": _title,
      "priority": _priority.name,
      "deadline": _deadline?.toIso8601String(),
      "completed": _completed,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json["title"],
      priority: Priority.values.firstWhere(
        (p) => p.name == json["priority"],
      ),
      deadline:
          json["deadline"] != null ? DateTime.parse(json["deadline"]) : null,
      completed: json["completed"] ?? false,
    );
  }

  @override
  String toString() {
    final status = _completed ? "terminée" : "en cours";
    final dl = _deadline != null ? _deadline.toString() : "aucune échéance";
    return "Task(title: $_title, priority: $_priority, deadline: $dl, statut: $status)";
  }
}
