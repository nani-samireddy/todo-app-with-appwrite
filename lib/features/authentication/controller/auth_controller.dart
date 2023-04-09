import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/apis/auth_api.dart';
import 'package:todo/apis/user_api.dart';
import 'package:todo/core/utils.dart';
import 'package:todo/features/home/view/home_view.dart';
import 'package:appwrite/models.dart' as account_model;
import 'package:todo/models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authAPI: ref.watch(authApiProvider),
    userAPI: ref.watch(userApiProvider),
  );
});

final currentUserProvider = FutureProvider((ref) {
  final user = ref.watch(authControllerProvider.notifier).currentUser();
  return user;
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  final UserAPI _userAPI;
  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false);

  void signUp(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    state = true;

    final res = await _authAPI.signUp(
      emailAddress: email,
      password: password,
      name: name,
    );

    res.fold((l) {
      state = false;
      showSnackBar(context, l.message);
    }, (r) async {
      final res2 = await _userAPI.saveUserData(
        user: UserModel(name: name, email: email, uid: r.$id),
      );

      state = false;

      res2.fold(
        (l) => showSnackBar(context, l.message),
        (r) => login(email: email, password: password, context: context),
      );
    });
  }

  void login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true;

    final res = await _authAPI.login(emailAddress: email, password: password);
    state = false;
    res.fold((l) {
      showSnackBar(context, l.message);
    }, (r) {
      log("Logged in successfully");
      Navigator.pushAndRemoveUntil(context, HomeView.route(), (route) => false);
    });
  }

  Future<account_model.Account?> currentUser() => _authAPI.currentAccount();
}
