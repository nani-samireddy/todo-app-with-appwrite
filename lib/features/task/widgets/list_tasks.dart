import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/loading_page.dart';
import 'package:todo/core/core.dart';
import 'package:todo/features/task/controller/task_controller.dart';
import 'package:todo/features/task/widgets/task_details.dart';

class TasksList extends ConsumerStatefulWidget {
  final bool allTasks;
  final TaskStatus? selectedTaskStatus;
  const TasksList({super.key, required this.allTasks, this.selectedTaskStatus});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TasksListState();
}

class _TasksListState extends ConsumerState<TasksList> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(allTasksProvider).when(data: (tasks) {
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => showTaskActionBottomSheet(
                taskActionWidget:
                    TaskDetails(newTask: false, task: tasks[index]),
                context: context),
            title: Text(tasks[index].title),
            subtitle: Text(tasks[index].description),
          );
        },
      );
    }, error: (error, stacktrace) {
      log(stacktrace.toString());
      return Center(child: Text(error.toString()));
    }, loading: () {
      return const Loader();
    });
  }
}
