import 'package:flutter/material.dart';
import 'package:test_project/model/todo.dart';
import 'package:test_project/widgets/todo_item.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  final _searchInputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Icon(Icons.menu), Text("T")]),
      ),
      backgroundColor: Color(0xFFF2F2F2),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              searchBar(),
              Expanded(
                  child: ListView(children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.all(5),
                  child: Text(
                    "All ToDo Items",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_foundToDo.length == 0 &&
                    _searchInputController.text.isEmpty)
                  InkWell(
                    onTap: () {
                      _displayAddToDo(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      height: 300,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.add),
                                iconSize: 50),
                            Text(
                              "Try adding some to do Item",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )
                          ]),
                    ),
                  )
                else if (_foundToDo.length == 0 &&
                    _searchInputController.text.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Opps, No results for \n ' +
                                _searchInputController.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              height: 1.5,
                            ),
                          ),
                        ]),
                  )
                else
                  for (ToDo todo in _foundToDo.reversed)
                    ToDoItem(
                        todo: todo,
                        onChange: _handleToDoChanges,
                        onDelete: _removeToDo),
              ]))
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayAddToDo(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _displayAddToDo(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Whats in your mind?'),
            content: Form(
              key: _formKey,
              child: TextFormField(
                onChanged: (value) {},
                autofocus: true,
                controller: _todoController,
                validator: (keyword) {
                  if (keyword == null || keyword.isEmpty) {
                    return "Field is required.";
                  }
                  return null;
                },
                decoration: InputDecoration(hintText: "Take dog for a walk"),
              ),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              TextButton(
                //color: Colors.red,
                //textColor: Colors.white,
                child: Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              // ignore: deprecated_member_use
              TextButton(
                //color: Colors.green,
                //textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  if (_formKey.currentState?.validate().toString() != "false") {
                    _addToDo(_todoController.text);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }

  Widget searchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => searchToDo(value),
        controller: _searchInputController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            prefixIcon: Icon(
              Icons.search,
              size: 20,
            ),
            border: InputBorder.none,
            hintText: 'Search'),
      ),
    );
  }

  void _handleToDoChanges(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _addToDo(String toDo) {
    setState(() {
      todosList.add(ToDo(id: DateTime.now().millisecond, todoText: toDo));
    });
    _todoController.clear();
  }

  void searchToDo(String keyword) {
    List<ToDo> results = [];
    if (keyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
              item.todoText.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }

  void _removeToDo(id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }
}
