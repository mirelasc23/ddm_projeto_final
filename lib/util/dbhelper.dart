import 'package:ddm_projeto_final/model/acesso.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ddm_projeto_final/model/planta.dart';
import 'package:ddm_projeto_final/model/rega.dart';
// import 'package:ddm_projeto_final/model/regiao.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('projeto.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    print("Banco aberto: $path");

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE sessao_usuario (
        uid TEXT PRIMARY KEY,
        nome TEXT,
        email TEXT,
        id_token TEXT,
        refresh_token TEXT,
        expira_em TEXT
      )
    ''');

    await _createPlantaRegaTables(db);
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await _createPlantaRegaTables(db);
    }
  }

  Future _createPlantaRegaTables(Database db) async {
    await db.execute('''
      CREATE TABLE planta (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        imagem TEXT,
        idRegiao INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE rega (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idPlanta INTEGER NOT NULL,
        dataRega TEXT NOT NULL,
        FOREIGN KEY (idPlanta) REFERENCES planta (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> salvarSessao(Acesso sessao) async {
    final db = await instance.database;
    await db.insert('sessao_usuario', {
      'uid': sessao.uid,
      'nome': sessao.nome,
      'email': sessao.email,
      'id_token': sessao.idToken,
      'refresh_token': sessao.refreshToken,
      'expira_em': sessao.expiraEm.toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Acesso?> buscarSessao() async {
    final db = await instance.database;
    final maps = await db.query('sessao_usuario', limit: 1);

    if (maps.isNotEmpty) {
      final res = maps.first;
      return Acesso(
        uid: res['uid'] as String,
        nome: res['nome'] as String,
        email: res['email'] as String,
        idToken: res['id_token'] as String,
        refreshToken: res['refresh_token'] as String,
        expiraEm: DateTime.parse(res['expira_em'] as String),
      );
    }
    return null;
  }

  Future<Acesso> atualizarTokens({
    required String novoIdToken,
    required String novoRefreshToken,
    required DateTime expiraEm,
  }) async {
    final db = await instance.database;

    await db.update('sessao_usuario', {
      'id_token': novoIdToken,
      'refresh_token': novoRefreshToken,
      'expira_em': expiraEm.toIso8601String(),
    });

    final sessaoAtualizada = await buscarSessao();
    return sessaoAtualizada!;
  }

  Future<void> limparSessao() async {
    final db = await instance.database;
    await db.delete('sessao_usuario');
  }


//plantas

  Future<int> inserirPlanta(Planta planta) async {
    final db = await instance.database;
    print(planta.toMap());
    final id = await db.insert('planta', planta.toMap());
    print("Salvou com id: $id");
    return id;
  }

  Future<List<Planta>> buscarPlantas() async {
    final db = await instance.database;
    final maps = await db.query('planta');
    return maps.map((map) => Planta.fromMap(map)).toList();
  }

  Future<Planta?> buscarPlantaPorId(int id) async {
    final db = await instance.database;
    final maps = await db.query('planta', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Planta.fromMap(maps.first);
  }

  Future<int> atualizarPlanta(Planta planta) async {
    final db = await instance.database;
    return await db.update(
      'planta',
      planta.toMap(),
      where: 'id = ?',
      whereArgs: [planta.id],
    );
  }

  Future<int> excluirPlanta(int id) async {
    final db = await instance.database;
    return await db.delete('planta', where: 'id = ?', whereArgs: [id]);
  }

//regas

Future<int> inserirRega(Rega rega) async {
    final db = await instance.database;
    return await db.insert('rega', rega.toMap());
  }

  Future<List<Rega>> buscarRegasPorPlanta(int idPlanta) async {
    final db = await instance.database;
    final maps = await db.query(
      'rega',
      where: 'idPlanta = ?',
      whereArgs: [idPlanta],
      orderBy: 'dataRega DESC',
    );
    return maps.map((map) => Rega.fromMap(map)).toList();
  }

  Future<int> excluirRega(int id) async {
    final db = await instance.database;
    return await db.delete('rega', where: 'id = ?', whereArgs: [id]);
  }


}