import 'package:ddm_projeto_final/model/model.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;

class DBUtil {
  static Future<sqlite.Database> _getDB() async {
    //local onde o banco de dados sera armazenado
    final databasePath = await sqlite.getDatabasesPath();
    //join para criar o caminho p arq de forma correta, independente do SO
    final arqBD = path.join(databasePath, "brotinho.db");

    //abrir o banco de dados, se nao existir, ele cria
    //funcao onCreate so eh chamada na primeira vez
    return sqlite.openDatabase(
      arqBD,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE Usuario(
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
            nome TEXT NOT NULL
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
}
