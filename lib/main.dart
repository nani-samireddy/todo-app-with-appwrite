import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/common/common.dart';
import 'package:todo/features/authentication/controller/auth_controller.dart';
import 'package:todo/features/authentication/view/signup_view.dart';
import 'package:todo/features/home/view/home_view.dart';
import 'package:todo/theme/app_theme.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

void main() {
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: AppTheme.theme,
      home: ref.watch(currentUserProvider).when(
            data: (user) {
              return user != null ? const HomeView() : const SignUpView();
            },
            error: (error, st) => ErrorPage(errorText: error.toString()),
            loading: () => const LoadingPage(),
          ),
    );
  }
}
