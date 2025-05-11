import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_flutter/blocs/note/note_bloc.dart';
import 'package:todo_app_flutter/blocs/note/note_event.dart';
import 'package:todo_app_flutter/blocs/note/note_state.dart';
import '../models/note.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoteLoaded) {
            return _buildNotesList(state.notes);
          } else {
            return const Center(child: Text('Failed to load notes.'));
          }
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'Notes',
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          letterSpacing: .5,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildNotesList(List<Note> notes) {
    if (notes.isEmpty) {
      return const Center(child: Text('No notes yet.'));
    }
    return SafeArea(
      child: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (_, index) {
          final note = notes[index];
          return NoteTask(note: note);
        },
      ),
    );
  }
}

class NoteTask extends StatelessWidget {
  final Note note;

  const NoteTask({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: _buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNoteHeader(context),
          const SizedBox(height: 8),
          Text(
            note.content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          letterSpacing: .5,
          fontSize: 20,
        ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.black12),
      borderRadius: BorderRadius.circular(24),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Row _buildNoteHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            note.title,
             style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          letterSpacing: .5,
          fontSize: 30,
        ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => _showEditNoteDialog(context, note: note),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () =>
              context.read<NoteBloc>().add(DeleteNote(note.id)),
        ),
      ],
    );
  }
}

void _showEditNoteDialog(BuildContext context, {Note? note}) {
  final titleController = TextEditingController(text: note?.title);
  final contentController = TextEditingController(text: note?.content);

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.white,
      title: _buildDialogTitle(),
      content: _buildDialogContent(titleController, contentController),
      actions: _buildDialogActions(context, titleController, contentController, note),
    ),
  );
}

Text _buildDialogTitle() {
  return Text(
    'Edit Note',
    style: GoogleFonts.poppins(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      letterSpacing: .5,
      fontSize: 14,
    ),
  );
}

SingleChildScrollView _buildDialogContent(
    TextEditingController titleController, TextEditingController contentController) {
  return SingleChildScrollView(
    child: Column(
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: 'Title'),
        ),
        TextField(
          controller: contentController,
          decoration: const InputDecoration(labelText: 'Content'),
          maxLines: 4,
        ),
      ],
    ),
  );
}

List<Widget> _buildDialogActions(
    BuildContext context,
    TextEditingController titleController,
    TextEditingController contentController,
    Note? note) {
  return [
    TextButton(
      onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
      child: const Text('Cancel'),
    ),
    TextButton(
      onPressed: () {
        final title = titleController.text.trim();
        final content = contentController.text.trim();
        if (title.isEmpty || content.isEmpty) return;

        final updatedNote = Note(
          id: note?.id ?? DateTime.now().toIso8601String(),
          title: title,
          content: content,
        );

        if (note == null) {
          context.read<NoteBloc>().add(AddNote(updatedNote));
        } else {
          context.read<NoteBloc>().add(UpdateNote(updatedNote));
        }

        Navigator.of(context, rootNavigator: true).pop();
      },
      child: const Text(
        'Update',
        style: TextStyle(color: Color(0xFFD57D47)),
      ),
    ),
  ];
}
