import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_flutter/blocs/task/task_bloc.dart';
import 'package:todo_app_flutter/blocs/task/task_event.dart';
import 'package:todo_app_flutter/models/task.dart';
import 'package:todo_app_flutter/utils/Bottom_bar.dart';
import 'package:todo_app_flutter/widgets/CustomInputField.dart';
import 'package:todo_app_flutter/widgets/customButton.dart';
import 'package:uuid/uuid.dart';
class CustomForm extends StatelessWidget {
   final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
           Text(
          'Add New Element',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
           CustomInputField(hintText: 'Title', controller: controller),
            const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(color: Color(0xFFD57D47)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomButton(
                text: 'Add',
                onPressed: () {
                context.read<TaskBloc>().add(AddTask(Task(
        id: Uuid().v4(),
        title: controller.text.trim(),
      )
      )
      );
      Navigator.pop(context);

                },
              ),
            ),
          ],
        ),

      ]
   );
  }

}