import 'package:ddm_projeto_final/model/usuario.dart';
import 'package:ddm_projeto_final/util/db.dart';
import 'package:flutter/material.dart';

class UsuarioProvider with ChangeNotifier{
  List<Usuario> _usuarios = [];
  final String _url = "https://teste-ddm-ifsc-default-rtdb.firebaseio.com/usuarios.json";

  List<Usuario> get pessoasDummy {
    _usuarios  = [
    /*Usuario(nome: "Maria", email: "email1@", senha: "xxx"),
    Usuario(nome: "João", email: "email1@", senha: "xxx"),
    Usuario(nome: "Ana", email: "email1@", senha: "xxx"),
    Usuario(nome: "Carlos", email: "email1@", senha: "xxx"),
    Usuario(nome: "Sofia", email: "email1@", senha: "xxx"),
    Usuario(nome: "Juarez", email: "email1@", senha: "xxx")*/
    ];
    return _usuarios;
  }

  List<Usuario> get usuarios => _usuarios;

  Future<void> carregaUsuarios() async{
    _usuarios = await DBUtil.list("Usuario")
      .then((res) =>
       _usuarios = res.map( (mapa) => Usuario.fromMap(mapa)).toList());
    notifyListeners();
  }

  void addUsuario(Usuario pessoa){
    DBUtil.insert(pessoa);
    _usuarios.add(pessoa);
    notifyListeners();
  }

  void removeUsuario(int id){
    DBUtil.delete("Usuario", id);
    _usuarios.removeWhere((pessoa) => pessoa.id == id);
    notifyListeners();
  }

}