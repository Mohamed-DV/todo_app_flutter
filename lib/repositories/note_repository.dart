import 'package:hive/hive.dart';
import '../models/note.dart';
class NoteRepository {
  final Box<Note> box = Hive.box<Note>('notes');

  Future<List<Note>> getNotes() async {
    return box.values.toList();
  }
  Future<void> addNote(Note note) async {
     await box.put(note.id, note);
  }
  Future<void> updateNote(Note note) async {
     final box = Hive.box<Note>('notes');
    await box.put(note.id, note);
  } 

  Future<void> deleteNote(String id) async {
    final box = Hive.box<Note>('notes');
    await box.delete(id);
  } 
}
