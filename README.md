# Todo List CLI — Dart

Application en ligne de commande de gestion de tâches, développée en **Dart pur** (sans Flutter), pour pratiquer la programmation orientée objet, les génériques, la gestion d'exceptions, la persistance JSON et les tests unitaires.

---

## Fonctionnalités

- Ajouter une tâche (titre, priorité `low`/`medium`/`high`, date limite optionnelle)
- Lister toutes les tâches
- Trier les tâches par priorité ou par échéance
- Marquer une tâche comme terminée
- Rechercher une tâche par titre
- Supprimer une tâche
- Persister automatiquement les tâches dans `data/task.json`
- Gérer les erreurs métier via des exceptions personnalisées

---

## Architecture du projet

```
Todo_List/
├── bin/
│   └── main.dart                  # Point d'entrée : menu CLI interactif
├── lib/
│   ├── models/
│   │   ├── task.dart
│   │   ├── urgent_task.dart       # hérite de Task
│   │   └── priority_enum.dart
│   ├── repository/
│   │   ├── repository.dart        # interface générique Repository<T>
│   │   └── task_repository.dart
│   ├── services/
│   │   ├── task_service.dart      # logique métier
│   │   └── storage_service.dart   # lecture/écriture du fichier JSON
│   └── exceptions/
│       ├── task_exception.dart
│       ├── invalid_task_exception.dart
│       ├── duplicate_task_exception.dart
│       └── task_not_found_exception.dart
├── utils/
│   └── json_helper.dart           # encode/decode JSON générique
├── data/
│   └── task.json                  # fichier de persistance local
├── test/
│   ├── task_test.dart
│   ├── urgent_task_test.dart
│   ├── task_repository_test.dart
│   ├── task_service_test.dart
│   ├── storage_service_test.dart
│   ├── json_helper_test.dart
│   └── exception_test.dart
├── pubspec.yaml
└── README.md
```

---

## Concepts techniques utilisés

| Exigence | Où |
|---|---|
| Classes abstraites + héritage | `Repository<T>` (abstraite), `Task` → `UrgentTask` |
| Interface | `Repository<T>` implémentée par `TaskRepository` |
| Génériques | `Repository<T>` |
| Exceptions personnalisées | `TaskException` et ses sous-classes |
| Persistance JSON | `StorageService` (lit/écrit `data/task.json` via `JsonHelper`) |
| Tests unitaires | `package:test`, 7 fichiers, 30+ tests |

---

## Installation

```bash
git clone https://github.com/valisoa01/Todo_List.git
cd Todo_List
dart pub get
```

## Lancer l'application

```bash
dart run bin/main.dart
```

Un menu interactif s'affiche dans le terminal :

```
1. Ajouter une tâche
2. Afficher les tâches
3. Marquer une tâche comme terminée
4. Supprimer une tâche
5. Rechercher une tâche par titre
6. Trier par priorité
7. Trier par échéance
8. Quitter
```

Chaque ajout/modification/suppression est automatiquement sauvegardé dans `data/task.json`, et rechargé au prochain lancement.

## Lancer les tests

```bash
dart test
```

Les tests couvrent les modèles, le repository, le service métier (y compris les cas d'erreur), la persistance JSON et les exceptions personnalisées. Les tests utilisent des fichiers temporaires isolés et ne touchent jamais à `data/task.json`.

---

## Licence

Projet réalisé à des fins pédagogiques.
