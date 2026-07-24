import 'task.dart';

class UrgentTask extends Task {
  final String alertMessage;

  UrgentTask({
    required super.title,
    required super.priority,
    required super.deadline,
    required this.alertMessage,  
  });

  void sendAlert() {
    print('ALERTE : The task"$title" Requires immediate attention! Contact: $alertMessage');
  }

  @override
  String toString() {
    return 'UrgentTask(title: $title, priorityEnum: $priority, deadline: $deadline,  alertMessage: $alertMessage)';
  }
}
