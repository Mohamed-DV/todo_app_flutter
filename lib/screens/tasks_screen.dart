import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/task/task_event.dart';
import '../blocs/task/task_state.dart';
import '../models/task.dart';

class TasksScreen extends StatefulWidget {
  @override
  TasksScreenState createState() => TasksScreenState();
}

class TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Tasks',
          style:  GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          letterSpacing: .5,
          fontSize: 20,
        ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            return TaskList(tasks: state.tasks);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  const TaskList({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return CardTask(task: task);
            },
          ),
        ),
      ],
    );
  }
}

class CardTask extends StatelessWidget {
  final Task task;

  const CardTask({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
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
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
            value: task.isCompleted,
            onChanged: (_) {
              final updatedTask = task..isCompleted = !task.isCompleted;
              context.read<TaskBloc>().add(UpdateTask(updatedTask));
                if (updatedTask.isCompleted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Task marked as completed'),
          duration: Duration(seconds: 2),
        ),
      );
    }
            },
          ),
          Text(task.title),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<TaskBloc>().add(DeleteTask(task.id));
                },
                icon: const Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () {
                  _showEditModal(context, task);
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void _showEditModal(BuildContext context, Task task) {
  final TextEditingController editController =
      TextEditingController(text: task.title);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Task',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: editController,
              decoration: const InputDecoration(
                hintText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      final updatedTask = task..title = editController.text.trim();
                      context.read<TaskBloc>().add(UpdateTask(updatedTask));
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Update',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(color: const Color(0xFFD57D47)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
void _showCompletionSnackbar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Task marked as completed'),
      duration: Duration(seconds: 2),
    ),
  );
}