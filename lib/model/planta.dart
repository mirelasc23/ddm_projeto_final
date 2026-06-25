import 'package:ddm_projeto_final/model/model.dart';

class Planta implements Model{
  int? _id;
  final String nome;

  Planta({int? id, required this.nome}) : _id = id;
  
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
      'nome': nome,
    };
  }
  
  factory Planta.fromMap(Map<String, dynamic> map) {
    return Planta(
      id: map['id'] as int?,
      nome: map['nome'] as String,
    );
  }
}