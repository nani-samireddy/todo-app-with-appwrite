import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todo/constants/constants.dart';
import 'package:todo/core/core.dart';
import 'package:todo/models/user_model.dart';

final userApiProvider = Provider((ref) {
  final db = ref.watch(appWriteDatabaseProvider);
  return UserAPI(db: db);
});

abstract class IuserAPI {
  FutureEitherVoid saveUserData({required UserModel user});
}

class UserAPI implements IuserAPI {
  final Databases _dbs;

  UserAPI({required Databases db}) : _dbs = db;

  @override
  FutureEitherVoid saveUserData({required UserModel user}) async {
    try {
      await _dbs.createDocument(
          databaseId: AppWrtieConstants.databaseId,
          collectionId: AppWrtieConstants.usersCollectionId,
          documentId: user.uid,
          data: user.toMap());
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(
          message: e.message ?? "Something went wrong while saving user data",
          stackTrace: stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(
          message: e.toString(),
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
