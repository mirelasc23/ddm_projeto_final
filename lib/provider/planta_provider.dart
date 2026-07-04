import 'package:ddm_projeto_final/model/planta.dart';
import 'package:ddm_projeto_final/util/db.dart';
import 'package:flutter/material.dart';

class PlantaProvider extends ChangeNotifier {
  List<Planta> _plantas = [];
  List<Planta> get plantas => _plantas;

  Future<void> adicionarPlanta(Planta planta) async {
    await DBUtil.insert(planta);
    //_plantas.add(planta);
    await carregarPlantas();
    notifyListeners();
  }

  Future<void> carregarPlantas() async {
    final response = await DBUtil.list('Planta');
    _plantas = response.map((map) => Planta.fromMap(map)).toList();
    notifyListeners();
  }
}
