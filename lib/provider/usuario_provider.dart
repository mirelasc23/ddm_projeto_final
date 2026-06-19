import 'dart:convert';

import 'package:ddm_projeto_final/model/usuario.dart';
import 'package:ddm_projeto_final/util/db.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider with ChangeNotifier{
  List<Usuario> _usuarios = [];
  final String _url = "https://teste-ddm-ifsc-default-rtdb.firebaseio.com/usuarios.json";

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

  List<Usuario> get usuarios => _usuarios;

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

  void addUsuario(Usuario usuario) async{
    final response = await http.post(
      Uri.parse(_url),
      body: jsonEncode(usuario.toMap()),
    );
    usuario.id = jsonDecode(response.body)["name"];
    _usuarios.add(usuario);
    notifyListeners();
  }

  void removeUsuario(int id){
    DBUtil.delete("Usuario", id);
    _usuarios.removeWhere((usuario) => usuario.id == id);
    notifyListeners();
  }

}