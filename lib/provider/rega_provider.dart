import 'package:ddm_projeto_final/model/rega.dart';
import 'package:ddm_projeto_final/util/db.dart';
import 'package:flutter/material.dart';

class RegaProvider extends ChangeNotifier {
  List<Rega> _regas = [];
  List<Rega> get regas => _regas;

  Future<void> regar(Rega rega) async {
    await DBUtil.insert(rega);
    _regas.add(rega);
    notifyListeners();
  }

  bool foiRegadaHoje() {
    final hoje = DateTime.now();
    final dataHoje =
        '${hoje.year}-${hoje.month.toString().padLeft(2, '0')}-${hoje.day.toString().padLeft(2, '0')}';
    return _regas.any((rega) => rega.dataRega == dataHoje);
  }

  Future<void> carregarRegasDoLocal(int idPlanta) async {
    final response = await DBUtil.list('  Rega');
    final regasFiltradas = response.where((map) => map['idPlanta'] == idPlanta);
    _regas = regasFiltradas.map((map) => Rega.fromMap(map)).toList();
    notifyListeners();
  }

  Future<void> carregarRegas() async {
    final response = await DBUtil.list('Rega');
    //final regasFiltradas = response.where((map) => map['idPlanta'] == idPlanta);
    _regas = response.map((map) => Rega.fromMap(map)).toList();
    notifyListeners();
  }
}
