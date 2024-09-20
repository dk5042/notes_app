import 'package:flutter/material.dart';
import '../classes/task_class.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.task});

  final Task task;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool editMode = false;

  late TextEditingController taskNameController;
  late TextEditingController taskDescriptionController;

  @override
  void initState() {
    super.initState();
    taskNameController = TextEditingController(text: widget.task.name);
    taskDescriptionController =
        TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Handle Android back button
          Navigator.pop(context,
              Task(taskNameController.text, taskDescriptionController.text));
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Handle back button at the top
                Navigator.pop(
                    context,
                    Task(taskNameController.text,
                        taskDescriptionController.text));
              },
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    readOnly: !editMode,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      hintText: 'Nazwa',
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: taskNameController,
                  ),
                  TextFormField(
                    readOnly: !editMode,
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
              editMode
                  ? Navigator.pop(
                      context,
                      Task(taskNameController.text,
                          taskDescriptionController.text))
                  : setState(() {
                      editMode = !editMode;
                    });
            },
            child: editMode
                ? const Icon(Icons.done_rounded)
                : const Icon(Icons.edit),
          ),
        ));
  }
}
