import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _estaAutenticado = false;

  bool get estaAutenticado => _estaAutenticado;

  Future<void> login(String email, String password) async {
    print('entra login');
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      this._estaAutenticado = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        //invalid-credential está sendo usado nas novas versoes do Firebase Authentication
        //print('Nenhum usuário encontrado para este e-mail.');
        print('Credenciais inválidas.');
      } else if (e.code == 'wrong-password') {
        print('Senha incorreta fornecida para este usuário.');
      } else {
        print('Erro do Firebase: ${e.code}');
      }
    } catch (e) {
      print(e);
    }

    // Simula uma chamada de login
    //await Future.delayed(Duration(seconds: 2));
    print('Usuário logado: $email');
  }

  Future<void> cadastra(String email, String password) async {
    print('entra cadastro');
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      this._estaAutenticado = true;
      print('Usuário registrado: $email');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('A senha fornecida é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        print('Já existe uma conta com esse e-mail.');
      }
    } catch (e) {
      print(e);
    }

    // Simula uma chamada de registro
    //await Future.delayed(Duration(seconds: 2));
    print('Usuário registrado: $email');
  }
}
