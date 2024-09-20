import 'package:flutter/material.dart';
import '../classes/task_class.dart';

class TaskAddPage extends StatefulWidget {
  const TaskAddPage({super.key});

  @override
  State<TaskAddPage> createState() => _TaskAddPageState();
}

class _TaskAddPageState extends State<TaskAddPage> {
  late TextEditingController taskNameController;
  late TextEditingController taskDescriptionController;
  late Task task;

  @override
  void initState() {
    super.initState();
    taskNameController = TextEditingController();
    taskDescriptionController = TextEditingController();
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Nazwa',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 20),
                controller: taskNameController,
              ),
              TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Notatka',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: taskDescriptionController,
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var taskName = taskNameController.text;
          var taskDescription = taskDescriptionController.text;
          task = Task(taskName, taskDescription);
          Navigator.pop(context, task);
        },
        child: const Icon(Icons.done_rounded),
      ),
    );
  }
}
