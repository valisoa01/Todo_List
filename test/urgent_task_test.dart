import 'package:test/test.dart';
import '../lib/models/urgent_task.dart';
import '../lib/models/task.dart';
import '../lib/models/priority_enum.dart';

void main() {
  group('UrgentTask', () {
    test('UrgentTask est une Task', () {
      final urgent = UrgentTask(
        title: "Serveur",
        priority: Priority.high,
        deadline: DateTime.now(),
        alertMessage: "Appeler l'admin",
      );

      expect(urgent is Task, true);
    });

    test('toString contient le titre et le message d\'alerte', () {
      final urgent = UrgentTask(
        title: "Serveur",
        priority: Priority.high,
        deadline: DateTime.now(),
        alertMessage: "Appeler l'admin",
      );

      expect(urgent.toString(), contains("Serveur"));
      expect(urgent.toString(), contains("Appeler l'admin"));
    });
  });
}
