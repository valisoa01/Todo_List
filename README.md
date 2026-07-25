#  Task Manager CLI - Dart

A command-line **Task Management System** developed in **Dart** to practice Object-Oriented Programming (OOP), Generics, JSON serialization, Exception Handling, Repository Pattern, and Unit Testing.

---

##  Project Overview

This application allows users to manage daily tasks through a command-line interface.

Users can:

-  Add a task
-  Display all tasks
-  Update a task
-  Delete a task
-  Search a task by title
-  Manage urgent tasks
-  Sort tasks by priority
-  Sort tasks by deadline
-  Save tasks into a JSON file
- Load tasks from a JSON file
-  Handle custom exceptions
-  Execute unit tests

---

#  Features

- Task creation
- Task update
- Task deletion
- Task search
- Task sorting
- JSON serialization
- File persistence
- Custom Exceptions
- Repository Pattern
- Service Layer
- Object-Oriented Programming
- Unit Testing

---

#  Project Architecture

```
task_manager/

│
├── bin/
│   └── main.dart
│
├── lib/
│   │
│   ├── models/
│   │   ├── task.dart
│   │   ├── urgent_task.dart
│   │   └── priority_enum.dart
│   │
│   ├── repository/
│   │   ├── repository.dart
│   │   └── task_repository.dart
│   │
│   ├── services/
│   │   └── task_service.dart
│   │
│   ├── exceptions/
│   │   ├── task_exception.dart
│   │   ├── invalid_task_exception.dart
│   │   ├── duplicate_task_exception.dart
│   │   └── task_not_found_exception.dart
│   │
│   └── utils/
│       └── json_helper.dart
│
├── data/
│   └── tasks.json
│
├── test/
│   ├── models/
│   ├── repository/
│   ├── services/
│   ├── exceptions/
│   └── utils/
│
├── pubspec.yaml
└── README.md
```

---

#  Technologies

- Dart
- dart:io
- dart:convert
- package:test

---

#  Object-Oriented Programming Concepts

This project demonstrates several OOP concepts.

### Encapsulation

Using private attributes with getters and setters.

```dart
String _title;
```

---

### Inheritance

```dart
class UrgentTask extends Task
```

---

### Abstraction

```dart
abstract class Repository<T>
```

---

### Generics

```dart
Repository<Task>
```

---

### Polymorphism

Using implementations of abstract repositories.

---

#  Models

## Task

Represents a task.

Attributes:

- title
- priority
- deadline

Methods:

- copyWith()
- toJson()
- fromJson()
- toString()

---

## UrgentTask

Extends Task.

Additional property:

- alertMessage

Additional behavior:

- sendAlert()

---

#  Repository Layer

Repository pattern separates business logic from data storage.

### Generic Repository

```dart
abstract class Repository<T>
```

Methods

- add()
- remove()
- update()
- getAll()

---

### TaskRepository

Stores tasks inside a List<Task>.

---

#  Service Layer

Contains the application's business logic.

Responsibilities:

- Validate tasks
- Detect duplicate tasks
- Search tasks
- Sort tasks
- Update tasks
- Remove tasks

---

#  Custom Exceptions

Implemented custom exceptions.

- TaskException
- InvalidTaskException
- DuplicateTaskException
- TaskNotFoundException

Example:

```dart
throw InvalidTaskException(
    "Task title cannot be empty.");
```

---

#  JSON Serialization

Convert a Task into JSON.

```dart
task.toJson();
```

Convert JSON into a Task.

```dart
Task.fromJson(json);
```

Example JSON

```json
{
  "title": "Learn Dart",
  "priority": "high",
  "deadline": "2026-08-01T00:00:00.000"
}
```

---

#  Data Persistence

Tasks are stored inside

```
data/tasks.json
```

The application automatically:

- Reads tasks from JSON
- Saves new tasks
- Updates existing tasks
- Deletes tasks

---

#  Console Menu

```
==============================
      TASK MANAGER
==============================

1. Add Task
2. Show Tasks
3. Update Task
4. Delete Task
5. Search Task
6. Sort by Priority
7. Sort by Deadline
8. Exit

Choose:
```

---

# Unit Testing

Tests are written using

```
package:test
```

Covered tests include:

### Models

- Task
- UrgentTask

### Repository

- add()
- remove()
- update()
- getAll()

### Services

- addTask()
- updateTask()
- removeTask()
- findTaskByTitle()
- sortByPriority()
- sortByDeadline()

### Exceptions

- InvalidTaskException
- DuplicateTaskException
- TaskNotFoundException

### JSON

- toJson()
- fromJson()
- encode()
- decode()

---

# ▶ Installation

Clone the repository

```bash
git clone https://github.com/valisoa01/Todo_List.git
```

Go inside the project

```bash
cd task_manager
```

Install dependencies

```bash
dart pub get
```

Run the application

```bash
dart run
```

Run tests

```bash
dart test
```

---

#  Learning Objectives

This project was built to practice:

- Dart syntax
- Object-Oriented Programming
- Repository Pattern
- Service Layer
- Generics
- Abstract Classes
- Exception Handling
- JSON Serialization
- File Handling
- Unit Testing
- Clean Architecture

---

#  License

This project is created for educational purposes.