class TaskModel {
  final String title;
  final String description;
  final String status;
  final String uid;
  final String? docId;
  TaskModel({
    required this.title,
    required this.description,
    required this.status,
    required this.uid,
    this.docId,
  });

  TaskModel copyWith({
    String? title,
    String? description,
    String? status,
    String? uid,
    String? docId,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      uid: uid ?? this.uid,
      docId: docId ?? this.docId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'status': status,
      'uid': uid,
    };
  }

  factory TaskModel.fromMap(
      {required Map<String, dynamic> map, String? docId}) {
    return TaskModel(
      title: map['title'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      uid: map['uid'] as String,
      docId: docId,
    );
  }
}
