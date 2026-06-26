import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool _estaAutenticado = false;
  bool get estaAutenticado => _estaAutenticado;
  bool _apresentaErro = false;
  bool get apresentaErro => _apresentaErro;

  // Coloque aqui a sua "Chave de API da Web" do console do Firebase
  final String _apiKey = "AIzaSyCNTlB_qCE1fi_hyQdQZeY_hEPI2xzzCFs";

  Future<void> login(String email, String password) async {
    print('entra login (REST API)');
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_apiKey',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final dadosReposta = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Usuário logado via REST: ${dadosReposta['email']}');
        // Aqui você pode salvar o dadosReposta['idToken'] se precisar usar em outras APIs
        _estaAutenticado = true;
      } else {
        _apresentaErro = true;
        _estaAutenticado = false;
        final String erro =
            dadosReposta['error']['message'] ?? 'Erro desconhecido';
        print('Erro no Login REST: $erro');

        // Mapeamento dos erros comuns do Firebase REST
        if (erro == 'EMAIL_NOT_FOUND' || erro == 'INVALID_LOGIN_CREDENTIALS') {
          print('Credenciais inválidas.');
        } else if (erro == 'INVALID_PASSWORD') {
          print('Senha incorreta.');
        }
      }
    } catch (e) {
      _apresentaErro = true;
      _estaAutenticado = false;
      print('Erro de conexão/rede no REST: $e');
    }

    notifyListeners();
  }

  Future<void> cadastra(String email, String password) async {
    print('entra cadastro (REST API)');
    final url = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_apiKey',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );

      final dadosReposta = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Usuário cadastrado via REST: ${dadosReposta['email']}');
        _estaAutenticado = true;
      } else {
        _apresentaErro = true;
        _estaAutenticado = false;
        final String erro =
            dadosReposta['error']['message'] ?? 'Erro desconhecido';
        print('Erro no Cadastro REST: $erro');

        if (erro == 'EMAIL_EXISTS') {
          print('Já existe uma conta com esse e-mail.');
        } else if (erro == 'WEAK_PASSWORD') {
          print('A senha fornecida é muito fraca.');
        }
      }
    } catch (e) {
      _apresentaErro = true;
      _estaAutenticado = false;
      print('Erro de conexão/rede no REST: $e');
    }

    notifyListeners();
  }
}
