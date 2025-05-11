import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_flutter/blocs/note/note_bloc.dart';
import 'package:todo_app_flutter/blocs/note/note_event.dart';
import 'package:todo_app_flutter/blocs/task/task_bloc.dart';
import 'package:todo_app_flutter/blocs/task/task_event.dart';
import 'package:todo_app_flutter/models/note.dart';
import 'package:todo_app_flutter/screens/notes_screen.dart';
import 'package:todo_app_flutter/screens/tasks_screen.dart';
import 'package:todo_app_flutter/widgets/CustomForm.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';
class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;

  final List<Widget> _screens =  [
  TasksScreen(),
  NotesScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      extendBody: true,
      body: _screens[_currentIndex],
     bottomNavigationBar: 
      CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: Colors.transparent,
        color: Color(0xFFD57D47),
        height: 70,
        items: const <Widget>[
          Icon(Icons.task, size: 30, color: Colors.white),
          Icon(Icons.note, size: 30, color: Colors.white),
         
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
    ),
     floatingActionButton: FloatingActionButton(
      backgroundColor: Color(0xFFD57D47),
        elevation: 4,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          if (_currentIndex == 0) {
            _showAddModal(context);
          } else if (_currentIndex == 1) {
            _showNoteDialog(context);
          }
        },
      ),
       
    );
  }



  void _showNoteDialog(BuildContext context, {Note? note}) {
  final titleController = TextEditingController(text: note?.title);
  final contentController = TextEditingController(text: note?.content);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Note' ,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Close the modal without affecting the navigation stack
                      Navigator.pop(context);
                    },
                    child:  Text(
                      'Cancel',
                      style: 
                      
                       GoogleFonts.poppins(
          color: Colors.red.withOpacity(.5),
          fontWeight: FontWeight.w500,
          letterSpacing: .5,
          fontSize: 14,
        ),
                      
                    ),
                  ),
                  ElevatedButton(
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

                      // Close the modal after saving
                      Navigator.pop(context);
                    },
                    child: Text( 'Add',
                           style:    GoogleFonts.poppins(
          color: Colors.brown.withOpacity(.5),
          fontWeight: FontWeight.w500,
          letterSpacing: .5,
          fontSize: 14,
        ),)
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
 void _showAddModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: CustomForm(),
        );
      },
    );
  }
}
