import 'dart:convert';
import 'package:ddm_projeto_final/model/acesso.dart';
import 'package:ddm_projeto_final/model/model.dart';
import 'package:ddm_projeto_final/util/db.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  bool _estaAutenticado = false;
  bool get estaAutenticado => _estaAutenticado;
  bool _apresentaErro = false;
  bool get apresentaErro => _apresentaErro;

  Acesso? _acessoAtual;
  Acesso? get acessoAtual => _acessoAtual;

  final String _apiKey = "AIzaSyCNTlB_qCE1fi_hyQdQZeY_hEPI2xzzCFs";

  Future<String?> obterTokenValido() async {
    if (_acessoAtual == null) {
      final lista = await DBUtil.list('Usuario');
      if (lista.isNotEmpty) {
        final dados = lista.first;
        _acessoAtual = Acesso(
          uid: dados['id'],
          nome: dados['nome'],
          email: dados['email'],
          idToken: dados['id_token'],
          refreshToken: dados['refresh_token'],
          expiraEm: DateTime.parse(dados['expira_em']),
        );
        _estaAutenticado = true;
      }
    }

    if (_acessoAtual == null) return null;

    if (!_acessoAtual!.precisaDeRefresh) {
      return _acessoAtual!.idToken;
    }

    print('Token expirado! Atualizando...');
    final url = Uri.parse(
      'https://securetoken.googleapis.com/v1/token?key=$_apiKey',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'refresh_token',
          'refresh_token': _acessoAtual!.refreshToken,
        },
      );

      if (response.statusCode == 200) {
        final dadosToken = jsonDecode(response.body);

        final segundos = int.parse(dadosToken['expires_in']);
        final novaExpiracao = DateTime.now().add(Duration(seconds: segundos));

        _acessoAtual = Acesso(
          uid: _acessoAtual!.uid,
          nome: _acessoAtual!.nome, 
          email: _acessoAtual!.email, 
          idToken: dadosToken['id_token'],
          refreshToken: dadosToken['refresh_token'],
          expiraEm: novaExpiracao,
        );

        await DBUtil.update('Usuario', {
          'id_token': _acessoAtual!.idToken,
          'refresh_token': _acessoAtual!.refreshToken,
          'expira_em': _acessoAtual!.expiraEm.toIso8601String(),
        }, _acessoAtual!.uid);

        print('Token renovado com sucesso!');
        return _acessoAtual!.idToken;
      } else {
        await logout();
        return null;
      }
    } catch (e) {
      print('Erro ao tentar renovar token: $e');
      return null;
    }
  }

  Future<void> login(String email, String password) async {
    _apresentaErro = false;
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

      final dadosResposta = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Usuário logado via REST: ${dadosResposta['email']}');
        _estaAutenticado = true;

        final segundos = int.parse(dadosResposta['expiresIn']);
        final dataExpiracao = DateTime.now().add(Duration(seconds: segundos));

        String nomeUsuario = dadosResposta['email'] ?? email.split('@')[0];

        _acessoAtual = Acesso(
          uid: dadosResposta['localId'],
          nome: nomeUsuario,
          email: dadosResposta['email'],
          idToken: dadosResposta['idToken'],
          refreshToken: dadosResposta['refreshToken'],
          expiraEm: dataExpiracao,
        );

        await DBUtil.insert(_acessoAtual! as Model);

        print('LOGIN: ${dadosResposta['idToken']}');
        print('EMAIL: ${dadosResposta['email']}');
      } else {
        _apresentaErro = true;
        _estaAutenticado = false;
        final String erro =
            dadosResposta['error']['message'] ?? 'Erro desconhecido';
        print('Erro no Login REST: $erro');

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

  Future<void> cadastra(String email, String password, String nome) async {
    _apresentaErro = false;
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

      final dadosResposta = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Usuário cadastrado via REST: ${dadosResposta['email']}');
        _estaAutenticado = true;

        final segundos = int.parse(dadosResposta['expiresIn']);
        final dataExpiracao = DateTime.now().add(Duration(seconds: segundos));

        //String nomeUsuario = dadosResposta['displayName'] ?? email.split('@')[0];
        String nomeUsuario = nome;

        _acessoAtual = Acesso(
          uid: dadosResposta['localId'],
          nome: nomeUsuario,
          email: dadosResposta['email'],
          idToken: dadosResposta['idToken'],
          refreshToken: dadosResposta['refreshToken'],
          expiraEm: dataExpiracao,
        );

        await DBUtil.insert(_acessoAtual! as Model);

        print('LOGIN: ${dadosResposta['idToken']}');
        print('EMAIL: ${dadosResposta['email']}');
      } else {
        _apresentaErro = true;
        _estaAutenticado = false;
        final String erro =
            dadosResposta['error']['message'] ?? 'Erro desconhecido';
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

  Future<void> logout() async {
    if (_acessoAtual != null) {
      await DBUtil.delete('Usuario', _acessoAtual!.uid);
    }
    _acessoAtual = null;
    _estaAutenticado = false;
    notifyListeners();
  }
}
