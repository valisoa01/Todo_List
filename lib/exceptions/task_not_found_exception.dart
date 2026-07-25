import 'task_exception.dart';

class TaskNotFoundException extends TaskException{
  TaskNotFoundException(String message):super(message);
}