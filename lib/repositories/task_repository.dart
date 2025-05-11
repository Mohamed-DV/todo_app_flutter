import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskRepository {
  final Box<Task> box = Hive.box<Task>('tasks');

  Future<List<Task>> getTasks() async{
    return box.values.toList();
   
  } 

  Future<void> addTask(Task task) async {
    await box.put(task.id, task);
  } 

  Future<void> updateTask(Task task) async {
    await box.put(task.id, task);
  }
  Future<void> deleteTask(String id) async {
     await box.delete(id);
  }
}