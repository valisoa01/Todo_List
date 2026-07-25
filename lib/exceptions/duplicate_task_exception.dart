import 'task_exception.dart';

class DuplicateTaskException extends TaskException{
  DuplicateTaskException(String message):super(message);
}