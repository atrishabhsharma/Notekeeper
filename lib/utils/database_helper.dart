
import 'package:notekeeper/models/note.dart';

///essentials imports for async , paths and sqflite

import "package:sqflite/sqflite.dart";
import 'dart:async';
import 'dart:io';
import "package:path_provider/path_provider.dart";

class DatabaseHelper {
  static DatabaseHelper
      _databaseHelper; // singleton DatabaseHelper (destroys after app shutsDown)

  static Database _database; // singleton database

  // database name and cloumn name

  String noteTable = 'note_Table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  //// named constructor to create instance of DatabaseHelper
  DatabaseHelper._createInstance();

// factory contstructor allows to return some values
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This will execute only once, Singleton object     
    }
    return _databaseHelper;
  }

// getter for database
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
      return _database;
    }
  }

  get id => null;

  Future<Database> initializeDatabase() async {
    //Get the directory for both android and ios to store Database

    Directory directory = await getApplicationDocumentsDirectory();

    // full path of the directory with notes.db as a name
    String path = directory.path + 'notes.db';

    // open and create the database at a given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

// SQL Statement code for creating  database

  void _createDb(Database db, int newVersion) async {
// this will form a table
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,'
        '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

// fetch operation : Get  all note  objects from database

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database; // reference to database

    var result = await db.query(noteTable, orderBy: '$colPriority ASC');

    return result;
  }

// Insert operation :Insert a Note  object to database

  Future<int> insertNote(Note note) async {
    Database db = await this.database;

// we have defined in note.dart (note is the object for class 'Note' in note.dart)
    var result = await db.insert(noteTable, note.toMap());

    return result;
  }

//update operation : Update a Note object and save it to database
  Future<int> updateNote(Note note) async {
    Database db = await this.database;

    var result = await db.update(noteTable, note.toMap(),where:'$colId= ?', whereArgs: [note.id]);

    return result;
  }

// delete operation : Delete a note object from database
Future<int> deleteNote(Note note) async {
    Database db = await this.database;

    var result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');

    return result;
  }


// countobject operation : Delete a note object from database
Future<int> getCount() async {
    Database db = await this.database;

    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');

    int result =Sqflite.firstIntValue(x);

    return result;
  }


//  Get the 'Map List' [ List<Map> ] and convert  it to 'Note List' [ List<NOte> ]

Future<List<Note>> getNoteList() async {

  var noteMapList = await getNoteMapList(); // get 'map list ' from database
  int count = noteMapList.length; // count thr number of map entries in DB table

  List<Note> notelist = List<Note>();
  // for loop to creare a '' note list from a 'map list'
  for(int i=0; i<count;i++) {
    notelist.add(Note.fromMapObject(noteMapList[i]));

  }

  return notelist;
}

}
