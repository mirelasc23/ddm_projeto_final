import 'dart:convert';

// import 'package:ddm_projeto_final/model/pessoa.dart';
import 'package:ddm_projeto_final/model/usuario.dart';
import 'package:ddm_projeto_final/util/db.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider with ChangeNotifier {
  List<Usuario> _usuarios = [];
  final String _url =
      "https://teste-ddm-ifsc-default-rtdb.firebaseio.com/pessoas.json";
  List<Usuario> get usuarios => _usuarios;

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

}
