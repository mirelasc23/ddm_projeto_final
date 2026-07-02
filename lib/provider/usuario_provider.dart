import 'dart:convert';

// import 'package:ddm_projeto_final/model/pessoa.dart';
import 'package:ddm_projeto_final/model/usuario.dart';
import 'package:ddm_projeto_final/util/db.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider with ChangeNotifier {
  // List<Pessoa> _pessoas = [];
  List<Usuario> _usuarios = [];
  final String _url =
      "https://teste-ddm-ifsc-default-rtdb.firebaseio.com/pessoas.json";
  List<Usuario> get usuarios => _usuarios;

  /*List<Usuario> get pessoasDummy {
    _usuarios  = [
    /*Usuario(nome: "Maria", email: "email1@", senha: "xxx"),
    Usuario(nome: "João", email: "email1@", senha: "xxx"),
    Usuario(nome: "Ana", email: "email1@", senha: "xxx"),
    Usuario(nome: "Carlos", email: "email1@", senha: "xxx"),
    Usuario(nome: "Sofia", email: "email1@", senha: "xxx"),
    Usuario(nome: "Juarez", email: "email1@", senha: "xxx")*/
    ];
    return _usuarios;
  }*/

  /*  List<Usuario> get usuarios => _usuarios;

  Future<void> carregaUsuarios() async{
    final response = await http.get(Uri.parse(_url));

    final dados = jsonDecode(response.body);
    dados.forEach((key, value) {
      value["id"] = key;
      final pessoa = Usuario.fromMap(value);
      _usuarios.add(pessoa);
    });
    notifyListeners();
  }
*/
  void addUsuario(Usuario usuario) async {
    final response = await http.post(
      Uri.parse(_url),
      body: jsonEncode(usuario.toMap()),
    );
    usuario.id = jsonDecode(response.body)["name"];
    _usuarios.add(usuario);
    notifyListeners();
  }

  void removeUsuario(int id) {
    DBUtil.delete("Usuario", id.toString());
    _usuarios.removeWhere((usuario) => usuario.id == id);
    notifyListeners();
  }

  /*
  List<Pessoa> get pessoas => _pessoas;

  Future<void> carregaPessoas() async {
    final response = await http.get(Uri.parse(_url));

    final dados = jsonDecode(response.body);
    dados.forEach((key, value) {
      value["id"] = key;
      final pessoa = Pessoa.fromMap(value);
      _pessoas.add(pessoa);
    });
    notifyListeners();
  }

  Future<void> addPessoa(Pessoa pessoa) async {
    final response = await http.post(
      Uri.parse(_url),
      body: jsonEncode(pessoa.toMap()),
    );
    pessoa.id = jsonDecode(response.body)["name"];
    _pessoas.add(pessoa);
    notifyListeners();
  }

  void removePessoa(String id) {
    //deve ser feito (remover no firebase)
  }*/
}
