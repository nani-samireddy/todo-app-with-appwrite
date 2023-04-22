import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/common.dart';
import 'package:todo/common/heading_text.dart';
import 'package:todo/core/core.dart';
import 'package:todo/features/authentication/controller/auth_controller.dart';
import 'package:todo/features/task/controller/task_controller.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/theme/pallete.dart';

class TaskDetails extends ConsumerStatefulWidget {
  final TaskModel? task;
  final bool newTask;
  const TaskDetails({super.key, required this.newTask, this.task});

  @override
  ConsumerState<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends ConsumerState<TaskDetails> {
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  TaskStatus currentTaskStatus = TaskStatus.pending;

  void _onSave() async {
    if (widget.newTask) {
      await ref.read(taskControllerProvider.notifier).addTask(
          task: TaskModel(
              title: taskTitleController.text,
              description: taskDescriptionController.text,
              status: currentTaskStatus.type,
              uid: ref.read(currentuserDetailsProvider).value!.uid),
          context: context);
    } else {
      await ref.read(taskControllerProvider.notifier).updateTask(
          oldTask: widget.task!,
          updatedTask: TaskModel(
              title: taskTitleController.text,
              description: taskDescriptionController.text,
              status: currentTaskStatus.type,
              uid: ref.read(currentuserDetailsProvider).value!.uid),
          context: context);
    }
  }

  @override
  void initState() {
    if (widget.task != null) {
      taskTitleController.text = widget.task!.title;
      taskDescriptionController.text = widget.task!.description;
      currentTaskStatus = widget.task!.status.toTastStatusTypeEnum();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.94,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Wrap(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: HeadingText(
                          content: "Add Task",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: CustomTextInputField(
                          controller: taskTitleController,
                          hintText: "Title",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: CustomTextInputField(
                          controller: taskDescriptionController,
                          hintText: "Description",
                          numberOfLines: 7,
                        ),
                      ),
                      const Text(
                        "Status: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        children: TaskStatus.values.map((e) {
                          return RadioListTile(
                              value: e,
                              groupValue: currentTaskStatus,
                              onChanged: (value) {
                                setState(() {
                                  currentTaskStatus = value as TaskStatus;
                                });
                              },
                              title: Text(e.type));
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: RoundedPrimaryButton(
                    text: "Save",
                    onTap: () {
                      _onSave();
                    },
                    backgroundColor: Pallete.buttonBackgroundColor,
                    textColor: Pallete.buttonTextColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
