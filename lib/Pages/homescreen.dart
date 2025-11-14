import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_todo/Pages/login.dart';
import 'package:my_todo/components/colors.dart';
import 'package:my_todo/components/db_helper.dart';
import 'package:my_todo/components/todoitem.dart';
import 'package:my_todo/model/ToDo.dart';
//import 'package:my_todo/components/AddTodo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DbHelper _DbHelper = DbHelper.instance;
  var todolist = <Todo>[];
  List<Todo> _searchToDo = [];
  String? _task;

  @override
  void initState() {
    _loadTodos();
    super.initState();
  }

  Future<void> _loadTodos() async {
    final todos = await _DbHelper.getTask();
    setState(() {
      todolist = todos;
      _searchToDo = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ABGColor,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                      child: Text(
                        "Todo Lists",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    for (Todo todoo in _searchToDo)
                      Todoitem(
                        todo: todoo,
                        onToDoChanged: _handleToDoChange,
                        onToDoDelete: () => _deleteTodoItem(todoo.id!),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              //String newTodoTitle = '';
              //String newTodoDesc = '';
              return AlertDialog(
                title: const Text('Add New Todo'),

                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'ENTER NEW TODO ',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _task = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    // TextField(
                    //   autofocus: true,
                    //   decoration: const InputDecoration(
                    //     hintText: 'Enter todo description',
                    //   ),
                    //   onChanged: (descvalue) {
                    //     newTodoDesc = descvalue;
                    //   },
                    // ),
                  ],
                ),

                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Add'),

                    onPressed: () async {
                      if (_task == null || _task!.trim().isEmpty) {
                        return; // ✅ Check before saving
                      }
                      await _DbHelper.addTask(Todo(title: _task!.trim()));
                      _searchToDo = await _DbHelper.getTask();

                      setState(() {
                        _task = null;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _handleToDoChange(Todo todo) async {
    if (todo.isDone == 0) {
      todo.isDone = 1;
    } else {
      todo.isDone = 0;
    }
    await _DbHelper.updateTask(todo);
    final updatedList = await _DbHelper.getTask();
    setState(() {
      _searchToDo = updatedList;
    });
  }

  Future<void> _deleteTodoItem(int id) async {
    print('Tapped delete on ID: $id');
    await DbHelper.instance.deleteTask(id); // ⬅ Delete from DB
    final updatedList = await DbHelper.instance.getTask();

    setState(() {
      todolist = updatedList;
      _searchToDo = updatedList;
    });
  }

  void _runSearch(String enteredKeyword) {
    List<Todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todolist;
    } else {
      results =
          todolist
              .where(
                (item) => item.title!.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
              )
              .toList();
    }
    setState(() {
      _searchToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: TextField(
        onChanged: (value) => _runSearch(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: ABlack, size: 30),
          prefixIconConstraints: BoxConstraints(maxHeight: 30, minWidth: 30),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(
            color: ABlack,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ABGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // IconButton(
          //   icon: Icon(Icons.menu, color: ABlack, size: 30),
          //   onPressed: () {},
          // ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 20,
                foregroundImage: AssetImage('assets/images/img.jpg'),
                //child: Icon(Icons.person),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
    );
  }
}
