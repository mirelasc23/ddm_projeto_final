// plant_provider.dart
import 'package:ddm_projeto_final/_proxima_etapa/model.dart';
import 'package:ddm_projeto_final/util/dbhelper.dart';
import 'package:flutter/material.dart';

class PlantProvider with ChangeNotifier {
  List<Ambiente> _ambientes = [];
  List<Planta> _plantasDoAmbienteSelecionado = [];

  List<Ambiente> get ambientes => _ambientes;
  List<Planta> get plantasDoAmbienteSelecionado =>
      _plantasDoAmbienteSelecionado;

  // Carrega todos os locais para plotar no OpenStreetMap
  Future<void> carregarAmbientes() async {
    final db = await DatabaseHelper.instance.database;
    final res = await db.query('ambientes');
    _ambientes = res.map((map) => Ambiente.fromMap(map)).toList();
    notifyListeners();
  }

  // Carrega as plantas de um local específico quando o usuário clica no marcador
  Future<void> carregarPlantasDoAmbiente(int ambienteId) async {
    final db = await DatabaseHelper.instance.database;
    final res = await db.query(
      'plantas',
      where: 'ambiente_id = ?',
      whereArgs: [ambienteId],
    );
    _plantasDoAmbienteSelecionado = res
        .map((map) => Planta.fromMap(map))
        .toList();
    notifyListeners();
  }

  // REGAR TODAS as plantas daquele ambiente específico simultaneamente
  Future<void> regarTodasDoAmbiente(int ambienteId) async {
    String agora = DateTime.now().toIso8601String();
    //await DatabaseHelper.instance.regarPlantasDoAmbiente(ambienteId, agora);

    // Atualiza a lista local na memória para refletir na UI
    await carregarPlantasDoAmbiente(ambienteId);
  }

  // REGAR APENAS UMA planta selecionada na lista daquele ambiente
  Future<void> regarPlantaUnica(int plantaId, int ambienteId) async {
    String agora = DateTime.now().toIso8601String();
    //await DatabaseHelper.instance.regarPlantaIndividual(plantaId, agora);

    // Atualiza a lista local na memória para refletir na UI
    await carregarPlantasDoAmbiente(ambienteId);
  }
}
