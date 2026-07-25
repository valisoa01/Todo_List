import 'task_exception.dart';

class InvalidTaskException extends TaskException{
  InvalidTaskException(String message) : super(message);
}