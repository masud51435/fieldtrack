class HomeEntity {
  final List<TodoEntity> todos;

  HomeEntity({required this.todos});
}

class TodoEntity {
  final String title;
  final String description;
  final bool isCompleted;
  final String dueAt;
  final String createdAt;
  final String updatedAt;
  final String id;

  TodoEntity({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.dueAt,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });
}
