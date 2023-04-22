import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:todo/constants/appwrite_constants.dart';
import 'package:todo/core/core.dart';
import 'package:todo/models/task_model.dart';

final taskApiProvider = Provider((ref) {
  return TasksAPI(db: ref.watch(appWriteDatabaseProvider));
});

abstract class ITasksAPI {
  FutureEitherVoid createTask({required TaskModel task});
  FutureEitherVoid updateTask(
      {required String documentId, required Map<dynamic, dynamic> data});
  Future<List<Document>> getAllTasks({required String uid});
}

class TasksAPI implements ITasksAPI {
  final Databases _db;
  TasksAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid createTask({required TaskModel task}) async {
    try {
      await _db.createDocument(
          databaseId: AppWrtieConstants.databaseId,
          collectionId: AppWrtieConstants.tasksCollectionId,
          documentId: ID.unique(),
          data: task.toMap());
      return right(null);
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
  FutureEitherVoid updateTask(
      {required String documentId, required Map<dynamic, dynamic> data}) async {
    try {
      await _db.updateDocument(
          databaseId: AppWrtieConstants.databaseId,
          collectionId: AppWrtieConstants.tasksCollectionId,
          documentId: documentId,
          data: data);
      return right(null);
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
  Future<List<Document>> getAllTasks({required String uid}) async {
    final docs = await _db.listDocuments(
      databaseId: AppWrtieConstants.databaseId,
      collectionId: AppWrtieConstants.tasksCollectionId,
    );
    return docs.documents;
  }
}
