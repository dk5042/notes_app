import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'task_class.dart';

class TaskManager {
  static const String tasksKey = 'tasks';

  static Future<void> saveTasks(List<Task> tasks) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> tasksJson =
        tasks.map((task) => jsonEncode(task.toJson())).toList();

    prefs.setStringList(tasksKey, tasksJson);
  }

  static Future<List<Task>> getTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? tasksJson = prefs.getStringList(tasksKey);

    if (tasksJson != null) {
      return tasksJson
          .map((taskJson) => Task.fromJson(jsonDecode(taskJson)))
          .toList();
    } else {
      return [];
    }
  }

  static Future<void> clearTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(tasksKey);
  }
}
