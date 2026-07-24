abstract class Repository<T> {
void add(T item);

void remove (T item);

List<T> getAll();

void update(T oldItem, T newItem);
}