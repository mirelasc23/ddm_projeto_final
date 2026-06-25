import 'package:ddm_projeto_final/util/rotas.dart';
import 'package:ddm_projeto_final/widgets/botao_login.dart';
import '../provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Modo { cadastro, login }

class FormLogin extends StatefulWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Modo _modo = Modo.login;

  final Map<String, String> _dadosForm = {'email': '', 'password': ''};

  bool _ehLogin() => _modo == Modo.login;
  bool _ehCadastro() => _modo == Modo.cadastro;

  void _trocaModoTela() {
    setState(() {
      if (_ehLogin()) {
        _modo = Modo.cadastro;
      } else {
        _modo = Modo.login;
      }
      print("Modo atual: ${_ehLogin() ? 'Login' : 'Cadastro'}");
    });
  }

  Future<void> _submit() async {
    //   setState(() => _isLoading = false);
    print('entra submit');

    final valido = _formKey.currentState?.validate() ?? false;

    if (!valido) return;

    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    if (_ehLogin()) {
      // Login
      print('_ehLogin');
      await authProvider.login(_dadosForm['email']!, _dadosForm['password']!);
    } else {
      // Registrar
      print('_ehCadastro');
      await authProvider.cadastra(
        _dadosForm['email']!,
        _dadosForm['password']!,
      );
    }

    setState(() => _isLoading = false);

    if (authProvider.estaAutenticado) {
      Navigator.pushNamed(context, Rotas.telaInicial);
    }
  }

  /*@override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(14),
        height: _ehLogin() ? 310 : 400,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'E-mail (login)'),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _dadosForm['email'] =
                    email ?? '', //acao de salvar formulario
                validator: (_email) {
                  //validacao
                  final email = _email ?? '';
                  if (!email.contains('@')) {
                    return 'Informe um e-mail válido.'; //com erro, com essa mensagem
                  }
                  //SEM ERRO DE VALIDACAO
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true, //nao mostra caracteres
                controller: _passwordController,
                onSaved: (password) => _dadosForm['password'] = password ?? '',
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.isEmpty || password.length < 3) {
                    return 'Informe uma senha válida';
                  }
                  return null;
                },
              ),
              if (_ehCadastro())
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirmar Senha',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  validator: _ehLogin()
                      ? null
                      : (_password) {
                          final password = _password ?? '';
                          //por isso precisa definir o controller da senha, para comparar as senhas
                          if (password != _passwordController.text) {
                            return 'Senhas informadas diferentes.';
                          }
                          return null;
                        },
                ),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                BotaoLogin(
                  texto: _ehLogin() ? 'Logar' : 'Novo Cadastro',
                  onPressed: () {
                    print('pressiona submit');
                    _submit();
                  },
                ),
              const Spacer(),
              BotaoLogin(
                texto: _ehLogin() ? 'Criar novo cadastro?' : 'Já tem conta?',
                onPressed: _trocaModoTela,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      height: _ehLogin() ? 310 : 400,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'E-mail (login)'),
              keyboardType: TextInputType.emailAddress,
              onSaved: (email) =>
                  _dadosForm['email'] = email ?? '', //acao de salvar formulario
              validator: (_email) {
                //validacao
                final email = _email ?? '';
                if (!email.contains('@')) {
                  return 'Informe um e-mail válido.'; //com erro, com essa mensagem
                }
                //SEM ERRO DE VALIDACAO
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Senha'),
              keyboardType: TextInputType.emailAddress,
              obscureText: true, //nao mostra caracteres
              controller: _passwordController,
              onSaved: (password) => _dadosForm['password'] = password ?? '',
              validator: (_password) {
                final password = _password ?? '';
                if (password.isEmpty || password.length < 3) {
                  return 'Informe uma senha válida';
                }
                return null;
              },
            ),
            if (_ehCadastro())
              TextFormField(
                decoration: const InputDecoration(labelText: 'Confirmar Senha'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                validator: _ehLogin()
                    ? null
                    : (_password) {
                        final password = _password ?? '';
                        //por isso precisa definir o controller da senha, para comparar as senhas
                        if (password != _passwordController.text) {
                          return 'Senhas informadas diferentes.';
                        }
                        return null;
                      },
              ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              BotaoLogin(
                texto: _ehLogin() ? 'Logar' : 'Novo Cadastro',
                onPressed: () {
                  print('pressiona submit');
                  _submit();
                },
              ),
            const Spacer(),
            BotaoLogin(
              texto: _ehLogin() ? 'Criar novo cadastro?' : 'Já tem conta?',
              onPressed: _trocaModoTela,
            ),
          ],
        ),
      ),
    );
  }
}
