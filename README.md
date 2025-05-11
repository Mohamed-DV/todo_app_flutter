# 📝 Flutter ToDo & Notes App

A simple and elegant Flutter application for managing tasks and notes, built using `flutter_bloc` for state management and `Hive` for local persistence. This app supports full CRUD operations and is designed with clean architecture and modularity in mind.

---

## 📦 Features

### ✅ Core Features
- Manage **ToDos** with title, completion toggle, add/edit/delete
- Manage **Notes** with title & content, add/edit/delete
- **Offline-first** using Hive for local persistence
- Clean Material Design UI


- Simple, responsive layout
- Modular code with `Bloc` for business logic

---

## 🔧 Architecture

This app follows a layered architecture using BLoC pattern:
## Folder Structure
lib/
├── blocs/
│ ├── note/
│ ├── task/
├── repositorie/
├── Models/
│ ├── /screens
│ └── utils/
└── main.dart
