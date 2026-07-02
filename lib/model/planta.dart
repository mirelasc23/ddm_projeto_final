import 'package:ddm_projeto_final/model/model.dart';

class Planta implements Model{
  int? _id;
  final String nome;
  final double lat;
  final double long;
  final String? imagem;
  final int? idRegiao;

  Planta({
    int? id, 
    required this.nome,
    required this.lat,
    required this.long,
    this.imagem,
    this.idRegiao,
    }) : _id = id;
  
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
      'latitude': lat,
      'longitude': long,
      'imagem': imagem,
      'idRegiao': idRegiao,
    };
  }
  
  factory Planta.fromMap(Map<String, dynamic> map) {
    return Planta(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      lat: map['latitude'] as double,
      long: map['longitude'] as double,
      imagem: map[ 'imagem'] as String?,
      idRegiao: map['idRegiao'] as int?,
    );
  }
}