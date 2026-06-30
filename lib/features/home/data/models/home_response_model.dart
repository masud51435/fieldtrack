import '../../domain/entities/home_entity.dart';

class HomeResponseModel {
  List<Todo>? data;

  HomeResponseModel({this.data});

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) =>
      HomeResponseModel(
        data: json["data"] == null
            ? []
            : List<Todo>.from(json["data"]!.map((x) => Todo.fromJson(x))),
      );

  HomeEntity toEntity() {
    final todos =
        data
            ?.map(
              (todo) => TodoEntity(
                title: todo.title ?? "",
                description: todo.description ?? "",
                isCompleted: todo.isCompleted ?? false,
                dueAt: todo.dueAt ?? "",
                createdAt: todo.createdAt ?? "",
                updatedAt: todo.updatedAt ?? "",
                id: todo.id ?? "",
              ),
            )
            .toList() ??
        [];
    return HomeEntity(todos: todos);
  }

  Map<String, dynamic> toJson() => {
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Todo {
  String? title;
  String? description;
  bool? isCompleted;
  String? dueAt;
  String? createdAt;
  String? updatedAt;
  String? id;

  Todo({
    this.title,
    this.description,
    this.isCompleted,
    this.dueAt,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    title: json["title"],
    description: json["description"],
    isCompleted: json["is_completed"],
    dueAt: json["due_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "is_completed": isCompleted,
    "due_at": dueAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "id": id,
  };

  TodoEntity toEntity() => TodoEntity(
    title: title ?? "",
    description: description ?? "",
    isCompleted: isCompleted ?? false,
    dueAt: dueAt ?? "",
    createdAt: createdAt ?? "",
    updatedAt: updatedAt ?? "",
    id: id ?? "",
  );
}
