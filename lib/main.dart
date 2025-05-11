import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_flutter/blocs/note/note_event.dart';
import 'package:todo_app_flutter/screens/notes_screen.dart';
import 'package:todo_app_flutter/utils/Splash_Screen.dart';
import 'blocs/task/task_event.dart';
import 'models/task.dart';
import 'models/note.dart';
import 'repositories/task_repository.dart';
import 'repositories/note_repository.dart';
import 'blocs/task/task_bloc.dart';
import 'blocs/note/note_bloc.dart';
import 'screens/tasks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Task>('tasks');
  await Hive.openBox<Note>('notes');

  runApp( MyApp(),) ;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TaskBloc(TaskRepository())..add(LoadTasks())),
        BlocProvider(create: (_) => NoteBloc(NoteRepository())..add(LoadNotes())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo & Notes App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: SplashScreen(),
      ),
    );
  }
}
