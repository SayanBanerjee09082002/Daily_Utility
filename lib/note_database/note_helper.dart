import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/note_database/note_model.dart';

class NoteDatabaseHelper {
  static final _dbName = 'noteDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'noteTable';

  static final columnId = '_Id';
  static final columnTitle = '_Title';
  static final columnDescription = '_Description';
  static final columnDate = '_Date';

  NoteDatabaseHelper._privateConstructor();

  static final NoteDatabaseHelper instance =
      NoteDatabaseHelper._privateConstructor();

  static Database? _notedatabase;

  Future<Database?> get notedatabase async {
    if(notedatabase!=null){
      return _notedatabase;
    }
    else{
      _notedatabase = _initializeNoteDatabase() as Database?;
      return _notedatabase;
    }
  }

  Future<Database?> _initializeNoteDatabase() async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path,version: _dbVersion, onCreate: _onCreate);
  }

  Future? _onCreate(Database db, int version){
    db.query(
      '''
      CREATE TABLE $_tableName(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $columnTitle TEXT, 
			$columnDescription TEXT, 
			$columnDate TEXT)')
      '''
    );
  }

  static Future<int?> insert(Note note) async{
    Database? db = await instance.notedatabase;
    return await db?.insert(_tableName, note.toMap());
  }

  static Future<List<Map<String, dynamic>>?> queryAll() async{
    Database? db = await instance.notedatabase;
    return await db?.query(_tableName);
  }

  static Future<int?> update(Note note) async{
    Database? db = await instance.notedatabase;
    return await db?.update(_tableName, note.toMap(), where: '$columnId = ?', whereArgs: [note.id]);
  }

  static Future<int?> delete(Note note) async{
    Database? db = await instance.notedatabase;
    return await db?.delete(_tableName, where: '$columnId = ?', whereArgs: [note.id]);
  }


}
