import 'package:appwrite/models.dart' as account_model;
import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todo/core/core.dart';

final authApiProvider = Provider((ref) {
  return AuthAPI(account: ref.watch(appWriteAccountProvider));
});




abstract class IAuthAPI {
  FutureEither<account_model.Account> signUp(
      {required String emailAddress,
      required String password,
      required String name});

  FutureEither<account_model.Session> login(
      {required String emailAddress, required String password});

  Future<account_model.Account?> currentAccount();
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

  @override
  FutureEither<account_model.Account> signUp(
      {required String emailAddress,
      required String password,
      required String name}) async {
    try {
      final account = await _account.create(
          userId: ID.unique(),
          name: name,
          email: emailAddress,
          password: password);
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
          message: e.message ?? "unexpected error occured",
          stackTrace: stackTrace));
    } catch (e, stackTrace) {
      return left(
        Failure(message: e.toString(), stackTrace: stackTrace),
      );
    }
  }

  @override
  FutureEither<account_model.Session> login(
      {required String emailAddress, required String password}) async {
    try {
      final session = await _account.createEmailSession(
          email: emailAddress, password: password);
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(Failure(
          message: e.message ?? "unexpected error occured",
          stackTrace: stackTrace));
    } catch (e, stackTrace) {
      return left(
        Failure(message: e.toString(), stackTrace: stackTrace),
      );
    }
  }

  @override
  Future<account_model.Account?> currentAccount() async {
    try {
      return await _account.get();
    } catch (e) {
      return null;
    }
  }
}
