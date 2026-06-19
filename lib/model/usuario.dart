import 'package:ddm_projeto_final/model/model.dart';

class Usuario implements Model {
  int? _id;
  final String nome;
  final String email;
  String senha;

  Usuario({required this.nome, required this.email, required this.senha});

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
      'senha': senha
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    var pessoa = Usuario(
      nome: map['nome'] as String,
      email: map['email'] as String,
      senha: map['senha'] as String,
    );
    pessoa.id = map['id'] as int;
    return pessoa;
  }
  
  @override
  String toString() {
    return 'Usuario {id: $_id, nome: $nome, email: $email}';
  }
}