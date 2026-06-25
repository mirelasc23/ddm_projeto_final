//import 'package:aula06_uso_api/models/endereco.dart';

class Pessoa {
  String? _id;
  final String nome;
  //final Endereco endereco;

  //Pessoa({required this.nome, required this.endereco});
  Pessoa({required this.nome});

  set id(String id) {
    _id = id;
  }

  String? get id => _id;

  Map<String, dynamic> toMap() {
    return {'id': _id, 'nome': nome}; //, 'endereco': endereco.toMap()};
  }

  factory Pessoa.fromMap(Map<String, dynamic> map) {
    var pessoa = Pessoa(
      nome: map['nome'] as String,
      //endereco: Endereco.fromMap(map['endereco'] as Map<String, dynamic>),
    );
    pessoa.id = map['id'] as String;
    return pessoa;
  }

  @override
  String toString() {
    return 'Pessoa{id: $_id, nome: $nome}';
  }
}
