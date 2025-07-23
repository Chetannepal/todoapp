import 'package:my_todo/model/ToDo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _db;
  DbHelper._();
  static final DbHelper instance = DbHelper._();

  final String _tasksTableName = "todo";
  final String _tasksIdcolumnName = "id";
  final String _tasksContentColumnName = "title";
  final String _tasksStatusColumnname = "is_done";

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDb();
    return _db!;
  }

  Future<Database> getDb() async {
    final dbDirPath = await getDatabasesPath();
    final dbPath = join(dbDirPath, "todo.db");
    final database = await openDatabase(
      dbPath,
      version: 2,
      onCreate: (db, version) {
        db.execute('''
     CREATE TABLE $_tasksTableName(
     $_tasksIdcolumnName INTEGER PRIMARY KEY AUTOINCREMENT,
     $_tasksContentColumnName TEXT NOT NULL,
     $_tasksStatusColumnname INTEGER NOT NULL
     )
     ''');
      },
    );
    return database;
  }

  Future<void> addTask(Todo todo) async {
    final db = await database;
    await db.insert(_tasksTableName, todo.toJson());
  }

  Future<List<Todo>> getTask() async {
    final db = await database;
    final data = await db.query(_tasksTableName);
    print(data);
    final todos = data.map((todo) => Todo.fromJson(todo)).toList();
    return todos;
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      _tasksTableName,
      where: '$_tasksIdcolumnName = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateTask(Todo todo) async {
    final db = await database;
    return await db.update(
      _tasksTableName,
      todo.toJson(),
      where: '$_tasksIdcolumnName = ?',
      whereArgs: [todo.id],
    );
  }
}
