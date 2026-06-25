import 'package:ddm_projeto_final/model/model.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;

class DBUtil{

  static Future<sqlite.Database> _getDB() async {
    //local onde o banco de dados sera armazenado
    final databasePath = await sqlite.getDatabasesPath();
    //join para criar o caminho p arq de forma correta, independente do SO
    final arqBD = path.join (databasePath, "pessoas.db");

    //abrir o banco de dados, se nao existir, ele cria
    //funcao onCreate so eh chamada na primeira vez
    return sqlite.openDatabase(
      arqBD,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE Usuario(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT NOT NULL,
            email TEXT NOT NULL,
            senha TEXT NOT NULL
          )
        ''');
        db.execute('''
          CREATE TABLE Rega(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            idPlanta INTEGER NOT NULL,
            dataRega TEXT NOT NULL
          )
        ''');
      },
    );
  } 

  static Future<void> insert(Model model) async {
    final db = await _getDB();
    model.id = await db.insert(model.runtimeType.toString(), model.toMap());
  }

  static Future<List<Map<String, dynamic>>> list (String table) async {
    final db = await _getDB();
    return db.query(table);
  }

  static  Future<int> delete(String table, int id) async {
    final db = await _getDB();
    return await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
}

}