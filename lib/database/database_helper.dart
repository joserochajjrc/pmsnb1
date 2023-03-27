import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pmsnb1/models/event__model.dart';
import 'package:pmsnb1/models/post_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class database_helper {
  static final nombreBD = 'TECBOOKBD';
  static final versionBD = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathBD = join(folder.path, nombreBD);

    return await openDatabase(
      pathBD,
      version: versionBD,
      onCreate: _createTable,
    );
  }

  _createTable(Database db, int version) {
    String query =
        'CREATE TABLE tblPost(idPost INTEGER PRIMARY KEY, dscPost VARCHAR(200), datePost DATE)';
    db.execute(query);
    query =
        'CREATE TABLE tblEvents(idEvent INTEGER PRIMARY KEY, dscEvent VARCHAR(200), dateEvent DATE, complete boolean)';
    db.execute(query);
  }

  Future<int> INSERTAR(String table, Map<String, dynamic> map) async {
    var conexion = await database;
    return await conexion.insert(table, map);
  }

  Future<int> ACTUALIZAR(String table, Map<String, dynamic> map) async {
    var conexion = await database;
    return await conexion
        .update(table, map, where: 'idPost = ?', whereArgs: [map['idPost']]);
  }

  Future<int> ELIMINAR(String table, int id) async {
    var conexion = await database;
    return await conexion.delete(table, where: 'idPost = ?', whereArgs: [id]);
  }

  Future<List<PostModel>> GETALLPOST() async {
    var conexion = await database;
    var result = await conexion.query('tblPost', orderBy: 'idPost DESC');
    return result.map((post) => PostModel.fromMap(post)).toList();
  }

  Future<int> ACTUALIZARevent(String table, Map<String, dynamic> map) async {
    var conexion = await database;
    return await conexion
        .update(table, map, where: 'idEvent = ?', whereArgs: [map['idEvent']]);
  }

  Future<int> ELIMINARevent(String table, int id) async {
    var conexion = await database;
    return await conexion.delete(table, where: 'idEvent = ?', whereArgs: [id]);
  }

  Future<List<EventModel>> GETALLEVENT() async {
    var conexion = await database;
    var result = await conexion.query('tblEvents', orderBy: 'dateEvent DESC');
    return result.map((post) => EventModel.fromMap(post)).toList();
  }
}
