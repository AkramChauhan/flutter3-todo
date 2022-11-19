class ToDo {
  int id;
  String todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: 1, todoText: "Todo Item 1", isDone: true),
      ToDo(id: 2, todoText: "Todo Item 2", isDone: false),
    ];
  }
}
