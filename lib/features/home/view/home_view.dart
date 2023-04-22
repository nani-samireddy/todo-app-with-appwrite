import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/core/utils.dart';
import 'package:todo/features/authentication/controller/auth_controller.dart';
import 'package:todo/features/task/widgets/list_tasks.dart';
import 'package:todo/features/task/widgets/task_details.dart';
import 'package:todo/theme/theme.dart';

class HomeView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeView());

  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  void _onLogout() {
    ref.watch(authControllerProvider.notifier).logout(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final userDetails = ref.watch(currentuserDetailsProvider).value;
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Text(
            userDetails == null ? "Todo" : 'Hello ${userDetails.name}👋',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _onLogout();
              },
              icon: const Icon(Icons.logout_rounded),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "All"),
              Tab(text: "Pending"),
              Tab(text: "Completed"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          isExtended: true,
          backgroundColor: Pallete.blackColor,
          onPressed: () {
            showTaskActionBottomSheet(
                context: context,
                taskActionWidget: const TaskDetails(
                  newTask: true,
                ));
          },
          icon: const Icon(Icons.add),
          label: const Text("New Task"),
        ),
        body: const TabBarView(
          children: [
            TasksList(allTasks: true),
            Center(child: Text("Pending")),
            Center(child: Text("Completed")),
          ],
        ),
      ),
    );
  }
}
