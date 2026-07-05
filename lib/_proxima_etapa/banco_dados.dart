// database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('plantas.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: (db) async => await db.execute(
        "PRAGMA foreign_keys = ON;",
      ), // Ativa chaves estrangeiras
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ambientes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE plantas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ambiente_id INTEGER NOT NULL,
        nome TEXT NOT NULL,
        ultima_regagem TEXT,
        FOREIGN KEY (ambiente_id) REFERENCES ambientes (id) ON DELETE CASCADE
      )
    ''');
  }

  // Métodos de insert/query omitidos para brevidade...

  // ATUALIZAR REGA: Atualiza todas as plantas de um ambiente específico
  Future<int> regarPlantasDoAmbiente(int ambienteId, String dataHora) async {
    final db = await instance.database;
    return await db.update(
      'plantas',
      {'ultima_regagem': dataHora},
      where: 'ambiente_id = ?',
      whereArgs: [ambienteId],
    );
  }

  // ATUALIZAR REGA INDIVIDUAL: Atualiza apenas uma planta
  Future<int> regarPlantaIndividual(int plantaId, String dataHora) async {
    final db = await instance.database;
    return await db.update(
      'plantas',
      {'ultima_regagem': dataHora},
      where: 'id = ?',
      whereArgs: [plantaId],
    );
  }
}
