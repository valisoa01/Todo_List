import '../models/task.dart';
import 'repository.dart';

class TaskRepository implements Repository<Task> {
  final List<Task> _tasks = [];
  @override
  void add(Task item) {
    _tasks.add(item);
  }
  @override
void remove(Task item) {
  _tasks.remove(item);
}
@override
List<Task> getAll() {
  return List.unmodifiable(_tasks);
}
@override
void update(Task oldItem, Task newItem) {
  final index = _tasks.indexOf(oldItem);

  if (index != -1) {
    _tasks[index] = newItem;
  }
}
}