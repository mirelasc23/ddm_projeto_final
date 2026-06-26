import 'package:ddm_projeto_final/model/model.dart';

class Usuario implements Model {
  int? _id;
  final String nome;
  final String email;
  String senha;
  int meta;

  Usuario({required this.nome, required this.email, required this.senha, required this.meta});

  @override
  set id(int id) {
    _id = id;
  }

  @override
  int? get id => _id;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'meta': meta
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    var pessoa = Usuario(
      nome: map['nome'] as String,
      email: map['email'] as String,
      senha: map['senha'] as String,
      meta: map['meta'] as int
    );
    pessoa.id = map['id'] as int;
    return pessoa;
  }
  
  @override
  String toString() {
    return 'Usuario {nome: $nome, email: $email, meta: $meta}';
  }
}