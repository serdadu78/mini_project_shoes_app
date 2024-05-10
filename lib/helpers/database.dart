import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mini_project_shoes_app/models/user_model.dart';


class DatabaseHelper {
  final databaseName = "shoes_app.db";
  String noteTable =
      "CREATE TABLE notes (noteId INTEGER PRIMARY KEY AUTOINCREMENT, noteTitle TEXT NOT NULL, noteContent TEXT NOT NULL, createdAt TEXT DEFAULT CURRENT_TIMESTAMP)";

  //Now we must create our user table into our sqlite db

  String users =
      "create table users (usrId INTEGER PRIMARY KEY AUTOINCREMENT, usrName TEXT UNIQUE, usrPassword TEXT)";

  //We are done in this section

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(users);
      await db.execute(noteTable);
    });
  }

  Future<bool> login(Users user) async {
    final Database db = await initDB();

    // I forgot the password to check
    var result = await db.rawQuery(
        "select * from users where usrName = '${user.usrName}' AND usrPassword = '${user.usrPassword}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //Sign up
  Future<int> signup(Users user) async {
    final Database db = await initDB();

    return db.insert('users', user.toMap());
  }

  Future<void> logout() async {
  final Database db = await initDB();
  
  await db.close();
}




  
}

//Search Method
  // Future<List<NoteModel>> searchNotes(String keyword) async {
  //   final Database db = await initDB();
  //   List<Map<String, Object?>> searchResult = await db
  //       .rawQuery("select * from notes where noteTitle LIKE ?", ["%$keyword%"]);
  //   return searchResult.map((e) => NoteModel.fromMap(e)).toList();
  // }

  //CRUD Methods

  //Create Note
  // Future<int> createNote(NoteModel note) async {
  //   final Database db = await initDB();
  //   return db.insert('notes', note.toMap());
  // }

  // //Get notes
  // Future<List<NoteModel>> getNotes() async {
  //   final Database db = await initDB();
  //   List<Map<String, Object?>> result = await db.query('notes');
  //   return result.map((e) => NoteModel.fromMap(e)).toList();
  // }

  // //Delete Notes
  // Future<int> deleteNote(int id) async {
  //   final Database db = await initDB();
  //   return db.delete('notes', where: 'noteId = ?', whereArgs: [id]);
  // }

  // //Update Notes
  // Future<int> updateNote(title, content, noteId) async {
  //   final Database db = await initDB();
  //   return db.rawUpdate(
  //       'update notes set noteTitle = ?, noteContent = ? where noteId = ?',
  //       [title, content, noteId]);
  // }