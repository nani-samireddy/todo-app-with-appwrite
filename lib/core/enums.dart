enum TaskStatus {
  pending("pending"),
  completed("completed");

  final String type;
  const TaskStatus(this.type);
}

extension ConvertTaskStatus on String {
  TaskStatus toTastStatusTypeEnum() {
    switch (this) {
      case 'pending':
        return TaskStatus.pending;
      case 'completed':
        return TaskStatus.completed;
      default:
        return TaskStatus.pending;
    }
  }
}
