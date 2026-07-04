import 'package:ddm_projeto_final/model/model.dart';
import 'package:ddm_projeto_final/model/planta.dart';
import 'package:ddm_projeto_final/model/rega.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;

class DBUtil {
  static Future<sqlite.Database> _getDB() async {
    final databasePath = await sqlite.getDatabasesPath();
    final arqBD = path.join(databasePath, "brotinho.db");

    return sqlite.openDatabase(
      arqBD,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE Acesso(
            id TEXT PRIMARY KEY,
            nome TEXT NOT NULL,
            email TEXT NOT NULL,
            id_token TEXT,
            refresh_token TEXT,
            expira_em TEXT
          )
        ''');
        db.execute('''
          CREATE TABLE Rega(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            idPlanta INTEGER NOT NULL,
            dataRega TEXT NOT NULL
          )
        ''');
        db.execute('''
          CREATE TABLE Planta(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL,
            imagem TEXT,
            idRegiao INTEGER
          )
        ''');
      },
    );
  }

  static Future<void> insert(Model model) async {
    final db = await _getDB();
    await db.insert(
      model.runtimeType.toString(),
      model.toMap(),
      conflictAlgorithm: sqlite.ConflictAlgorithm.replace,
    );
    //return await db.insert('Planta', model.toMap());
  }

  static Future<int> update(
    String table,
    Map<String, dynamic> data,
    dynamic id,
  ) async {
    final db = await _getDB();
    return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> list(String table) async {
    final db = await _getDB();
    return db.query(table);
  }

  static Future<int> delete(String table, String id) async {
    final db = await _getDB();
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  //plantas

  Future<int> inserirPlanta(Planta planta) async {
    final db = await _getDB();
    return await db.insert('planta', planta.toMap());
  }

  static Future<List<Planta>> buscarPlantas() async {
    final db = await _getDB();
    final maps = await db.query('planta');
    return maps.map((map) => Planta.fromMap(map)).toList();
  }

  Future<Planta?> buscarPlantaPorId(int id) async {
    final db = await _getDB();
    final maps = await db.query('planta', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Planta.fromMap(maps.first);
  }

  Future<int> atualizarPlanta(Planta planta) async {
    final db = await _getDB();
    return await db.update(
      'planta',
      planta.toMap(),
      where: 'id = ?',
      whereArgs: [planta.id],
    );
  }

  Future<int> excluirPlanta(int id) async {
    final db = await _getDB();
    return await db.delete('planta', where: 'id = ?', whereArgs: [id]);
  }

  //regas

  Future<int> inserirRega(Rega rega) async {
    final db = await _getDB();
    return await db.insert('rega', rega.toMap());
  }

  Future<List<Rega>> buscarRegasPorPlanta(int idPlanta) async {
    final db = await _getDB();
    final maps = await db.query(
      'rega',
      where: 'idPlanta = ?',
      whereArgs: [idPlanta],
      orderBy: 'dataRega DESC',
    );
    return maps.map((map) => Rega.fromMap(map)).toList();
  }

  Future<int> excluirRega(int id) async {
    final db = await _getDB();
    return await db.delete('rega', where: 'id = ?', whereArgs: [id]);
  }
}
