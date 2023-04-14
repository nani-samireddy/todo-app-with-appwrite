import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/apis/tasks_api.dart';
import 'package:todo/models/task_model.dart';
import '../../../core/core.dart';
import '../../authentication/controller/auth_controller.dart';

final taskControllerProvider =
    StateNotifierProvider<TaskController, bool>((ref) {
  return TaskController(tasksAPI: ref.watch(taskApiProvider));
});

final allTasksProvider = FutureProvider((ref) async {
  final taskController = ref.watch(taskControllerProvider.notifier);

  return taskController.getAllTasks(
      uid: ref.read(currentuserDetailsProvider).value!.uid);
});

class TaskController extends StateNotifier<bool> {
  final TasksAPI _tasksAPI;
  TaskController({required TasksAPI tasksAPI})
      : _tasksAPI = tasksAPI,
        super(false);

  FutureVoid addTask(
      {required TaskModel task, required BuildContext context}) async {
    final res = await _tasksAPI.createTask(task: task);
    res.fold(
        (l) => {
              showSnackBar(context: context, content: l.message),
            },
        (r) => {
              showSnackBar(context: context, content: "Task Added "),
              Navigator.pop(context),
            });
  }

  FutureVoid updateTask(
      {required TaskModel oldTask,
      required TaskModel updatedTask,
      required BuildContext context}) async {
    final data = compareMaps(map1: oldTask.toMap(), map2: updatedTask.toMap());
    final res =
        await _tasksAPI.updateTask(documentId: oldTask.docId!, data: data);
  }

  Future<List<TaskModel>> getAllTasks({required String uid}) async {
    final tasksDocsList = await _tasksAPI.getAllTasks(uid: uid);
    return tasksDocsList
        .map((e) => TaskModel.fromMap(map: e.data ?? {}, docId: e.$id))
        .toList();
  }
}
