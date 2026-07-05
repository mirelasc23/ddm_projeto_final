import 'package:ddm_projeto_final/model/planta.dart';
import 'package:ddm_projeto_final/model/rega.dart';
import 'package:ddm_projeto_final/provider/rega_provider.dart';
import 'package:ddm_projeto_final/util/db.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  Future<void> regarPlanta(BuildContext context, Planta planta) async {
    final provider = Provider.of<RegaProvider>(context, listen: false);
    final hoje = DateTime.now();
    final dataHoje =
        '${hoje.year}-${hoje.month.toString().padLeft(2, '0')}-${hoje.day.toString().padLeft(2, '0')}';
    final rega = Rega(idPlanta: 1, dataRega: dataHoje);
    provider.regar(rega);
    notifyListeners();
  }
}
