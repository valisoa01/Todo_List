import 'package:test/test.dart';
import '../lib/exceptions/task_exception.dart';
import '../lib/exceptions/duplicate_task_exception.dart';
import '../lib/exceptions/invalid_task_exception.dart';
import '../lib/exceptions/task_not_found_exception.dart';

void main() {
  group('Exceptions', () {
    test('TaskException contient le bon message', () {
      final exception = TaskException("Erreur");

      expect(exception.toString(), "TaskException: Erreur");
    });

    test('DuplicateTaskException affiche son propre type', () {
      final exception = DuplicateTaskException("Doublon");

      expect(exception.toString(), "DuplicateTaskException: Doublon");
    });

    test('InvalidTaskException affiche son propre type', () {
      final exception = InvalidTaskException("Invalide");

      expect(exception.toString(), "InvalidTaskException: Invalide");
    });

    test('TaskNotFoundException affiche son propre type', () {
      final exception = TaskNotFoundException("Introuvable");

      expect(exception.toString(), "TaskNotFoundException: Introuvable");
    });
  });
}
