import 'package:flutter/material.dart';
import '../classes/task_manager.dart';
import 'task_add_page.dart';
import 'task_page.dart';
import '../classes/task_widget.dart';
import '../classes/task_class.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();

    TaskManager.getTasks().then((retrievedTasks) {
      setState(() {
        tasks = retrievedTasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notatnik'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => taskWidget(
          name: tasks[index].name,
          description: tasks[index].description,
          onPressed: () => {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Czy na pewno chcesz usunąć?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        tasks.removeAt(index);
                        TaskManager.clearTasks();
                        TaskManager.saveTasks(tasks);
                      });
                    },
                    child: const Text('Tak'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Nie'),
                  ),
                ],
              ),
            ),
          },
          onTap: () => _editTask(context, index),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _newTask(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _editTask(BuildContext context, int index) async {
    final task = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskPage(task: tasks[index])),
    );
    if (!context.mounted) return;
    setState(() {
      if (task != null) {
        tasks.removeAt(index);
        tasks.insert(0, task);
        TaskManager.clearTasks();
        TaskManager.saveTasks(tasks);
      }
    });
  }

  Future<void> _newTask(BuildContext context) async {
    final task = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TaskAddPage()),
    );
    if (!context.mounted) return;
    setState(() {
      if (task != null) {
        tasks.insert(0, task);
        TaskManager.clearTasks();
        TaskManager.saveTasks(tasks);
      }
    });
  }
}
