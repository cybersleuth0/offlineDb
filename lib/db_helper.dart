import 'dart:io';

import 'package:offlinedb/NoteModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Db_helper {
  //this is KEY we can use in case if we forgotten the correct value
  static String TABLE_NAME = "NOTES";
  static String COLUMN_ID = "NID";
  static String COLUMN_TITLE = "TITLE";
  static String COLUMN_DESC = "DESC";
  static String COLUMN_CREATED_AT = "CREATED_AT";

  //this is simple constructor
  //Db_helper();if we will simple constructor then there is a chance that we
  // might multiple instances of the class or multiple objects of the class
  //we don't want that we have to make it private
  Db_helper._(); //private constructor

  /*Db_helper getInstance() {
    return Db_helper._();//Since we made constructor private we can't access it directly
    //we have to access it through this function
  }*/
  // Since this is returning only one thing so we can use single line return
  static Db_helper getInstance() => Db_helper._();

  //now we have to open a Database
  //this function will help us to open a database
  Future<Database> openDb() async {
    // this getApplicationDocumentsDirectory() we are getting this from path_provider package
    //it will return a future<Directory>. it will help us to get the path of the directory from user mobile
    Directory appDiretory = await getApplicationDocumentsDirectory();

    //now we have to create a path for the database
    // this join() function we are getting this from path package
    String dbPath = join(appDiretory.path, "notes.db");

    //we are getting this openDatabase() function from sqflite package
    //and it return future<database> so we have to made our function async
    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      //now we have to create a table for that we are using execute() function
      db.execute(
          "CREATE TABLE $TABLE_NAME ( $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,$COLUMN_TITLE TEXT,$COLUMN_DESC TEXT,$COLUMN_CREATED_AT TEXT)");
      //THIS will create a table named NOTES with 4 columns
    });
  }

//Now once we created a way to access the database instead of calling openDb
//multiple times we should store the 1 database in a variable
  Database?
      _db; //since we want database that's why type is Database of variable

//now we have to check if if _db is null means database is not created is not
// then we have to create a database
  Future<Database> getdb() async {
    // if (_db != null) {
    //   return _db!;
    // } else {
    //   return _db = await openDb();
    // }
    //we can use this instead of above code
    //we will use ternary operator
    //_db = _db ?? await openDb();
    _db ??= await openDb();
    return _db!;
    //if _db is null then part after this "??" will be return else part before
    // this "??" will be return
  }

  //now we have to add a note
  Future<bool> addnote({required NoteModel addnotemodel}) async {
    var database = await getdb();
    //roweffected is >0 it means our data inserted successfully
    //roweffected is <0 it means our data not inserted successfully
    int roweffected = await database.insert(TABLE_NAME, addnotemodel.tomap());
    return roweffected > 0;
  }

  Future<List<NoteModel>> fetchallnotes() async {
    var database = await getdb();
    List<Map<String, dynamic>> notes = await database.query(TABLE_NAME);
    List<NoteModel> mnotes = [];
    // for (int i = 0; i < notes.length; i++) {
    //   NoteModel eachnote = NoteModel.frommap(notes[i]);
    //   mnotes.add(eachnote);
    // }

    for (Map<String, dynamic> eachNotes in notes) {
      mnotes.add(NoteModel.frommap(eachNotes));
    }
    return mnotes;
  }

  Future<bool> updatenote(NoteModel updatenote) async {
    var database = await getdb();
    var roweffected = await database.update(TABLE_NAME, updatenote.tomap(),
        where: "$COLUMN_ID = ${updatenote.nId}");
    return roweffected > 0;
  }

  Future<bool> deletenote(int id) async {
    var database = await getdb();
    var roweffected =
        await database.delete(TABLE_NAME, where: "$COLUMN_ID=$id");
    return roweffected > 0;
  }
}
