class Todo {
  int? id;
  String? title;
  int isDone;

  Todo({this.id, required this.title, this.isDone = 0});
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int,
      title: json['title'],
      isDone: json['is_done'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'is_done': isDone};
  }
}
