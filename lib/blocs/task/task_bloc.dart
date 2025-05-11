import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/task_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskLoading()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      final tasks = await repository.getTasks();
      emit(TaskLoaded(tasks));
    });

    on<AddTask>((event, emit) async {
      await repository.addTask(event.task);
      add(LoadTasks());
    });

    on<UpdateTask>((event, emit) async {
      await repository.updateTask(event.task);
      add(LoadTasks());
    });

    on<DeleteTask>((event, emit) async {
      await repository.deleteTask(event.taskId);
      add(LoadTasks());
    });
  }
}