import 'priority_enum.dart';

class Task {
  String _title;
  Priority _priority;
  DateTime _deadline;

  Task({
    required String title,
    required Priority priority,
    required DateTime deadline,
  })  : _title = title,
        _priority = priority,
        _deadline = deadline;

  String get title => _title;
  Priority get priority => _priority;
  DateTime get deadline => _deadline;

  set title(String value) {
    if (value.trim().isNotEmpty) {
      _title = value;
    }
  }

  set priority(Priority value) {
    _priority = value;
  }

  set deadline(DateTime value) {
    _deadline = value;
  }

  Task copyWith({
    String? title,
    Priority? priority,
    DateTime? deadline,
  }) {
    return Task(
      title: title ?? _title,
      priority: priority ?? _priority,
      deadline: deadline ?? _deadline,
    );
  }

  @override
  String toString() {
    return 'Task(title: $_title, priority: $_priority, deadline: $_deadline)';
  }
}