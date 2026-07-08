import 'package:ddm_projeto_final/model/model.dart';

class Rega implements Model {
  int? _id;
  final int idPlanta;
  final String dataRega;

  Rega({int? id, required this.idPlanta, required this.dataRega}) : _id = id;

  @override
  set id(int id) {
    _id = id;
  }

  @override
  int? get id => _id;

  @override
  Map<String, dynamic> toMap() {
    return {
      if (_id != null) 'id': _id,
      'idPlanta': idPlanta,
      'dataRega': dataRega,
    };
  }

  factory Rega.fromMap(Map<String, dynamic> map) {
    final int idDb = map['id'] as int;

    var rega = Rega(
      id: map['id'] as int?,
      idPlanta: map['idPlanta'] as int,
      dataRega: map['dataRega'] as String,
    );
    rega._id = idDb;

    return rega;
  }

  @override
  String toString() {
    return 'Planta(ID: $id, idPlanta: $idPlanta, dataRega: $dataRega)';
  }
}
