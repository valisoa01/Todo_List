 
import 'priority_enum.dart';
class Task {
  String _title;
  Priority_enum _priority_enum;
  DateTime _deadline;

  Task({
    required String title,
    required Priority_enum priority_enum,
    required DateTime deadline,
  })  : _title = title,
        _priority_enum = priority_enum,
        _deadline = deadline;

  String get title => _title;
  Priority_enum get priority_enum => _priority_enum;
  DateTime get deadline => _deadline;

  set title(String value) {
    if (value.trim().isNotEmpty) {
      _title = value;
    }
  }

  set priority_enum(Priority_enum value) {
    _priority_enum = value;
  }

  set deadline(DateTime value) {
    _deadline = value;
  }

  Task copyWith({
    String? title,
    Priority_enum? priority_enum,
    DateTime? deadline,
  }) {
    return Task(
      title: title ?? _title,
      priority_enum: priority_enum ?? _priority_enum,
      deadline: deadline ?? _deadline,
    );
  }

  @override
  String toString() => 'DartItem(_title: $_title, _priority_enum: $_priority_enum, _deadline: $_deadline)';
}
