import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/note_repository.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository repository;

  NoteBloc(this.repository) : super(NoteLoading()) {
    on<LoadNotes>((event, emit) async {
      emit(NoteLoading());
      final notes = await repository.getNotes();
      emit(NoteLoaded(notes));
    });

    on<AddNote>((event, emit) async {
      await repository.addNote(event.note);
      add(LoadNotes());
    });

    on<UpdateNote>((event, emit) async {
      await repository.updateNote(event.note);
      add(LoadNotes());
    });

    on<DeleteNote>((event, emit) async {
      await repository.deleteNote(event.noteId);
      add(LoadNotes());
    });
  }
}