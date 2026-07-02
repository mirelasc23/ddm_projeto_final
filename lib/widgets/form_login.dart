import 'package:ddm_projeto_final/util/fontes.dart';
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
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Modo _modo = Modo.login;
  String? erro;

  final Map<String, String> _dadosForm = {
    'email': '',
    'password': '',
    'nome': '',
  };

  bool _ehLogin() => _modo == Modo.login;
  bool _ehCadastro() => _modo == Modo.cadastro;

  void _trocaModoTela() {
    setState(() {
      _formKey.currentState?.reset();

      if (_ehLogin()) {
        _modo = Modo.cadastro;
      } else {
        _modo = Modo.login;
      }

      _emailController.clear();
      _passwordController.clear();
      _nomeController.clear();

      _dadosForm['email'] = '';
      _dadosForm['password'] = '';
      _dadosForm['nome'] = '';

      print("Modo atual: ${_ehLogin() ? 'Login' : 'Cadastro'}");
    });
  }

  Future<void> _submit() async {
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
        _dadosForm['nome']!,
      );
    }

    setState(() => _isLoading = false);

    if (authProvider.estaAutenticado) {
      Navigator.pushNamed(context, Rotas.telaInicial);
    }
  }

  InputDecoration _estiloInput(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: const Color.fromRGBO(255, 255, 255, 0.53),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0),
        borderSide: const BorderSide(
          color: Color.from(alpha: 1.0, red: 0.13, green: 0.59, blue: 0.95),
          width: 1.5,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tamanhoTela = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(30),
      //height: _ehLogin() ? 310 : tamanhoTela.height * 0.6,
      height: tamanhoTela.height * 0.6,
      child: Form(
        key: _formKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  // Força a coluna a ter no mínimo a altura total disponível do Container
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    spacing: 16,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Agora vai funcionar!
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_ehCadastro())
                        TextFormField(
                          controller: _nomeController,
                          decoration: _estiloInput('Nome'),
                          style: TextStyle(
                            color: Color.from(
                              alpha: 1.0,
                              red: 0.13,
                              green: 0.59,
                              blue: 0.95,
                            ),
                            fontFamily: AppFonts.mairy,
                          ),
                          onSaved: (nome) => _dadosForm['nome'] = nome ?? '',
                          validator: (_nome) {
                            //validacao
                            final nome = _nome ?? '';
                            if (nome.isEmpty || nome.length < 3) {
                              return 'Insira seu nome';
                            }
                            //SEM ERRO DE VALIDACAO
                            return null;
                          },
                        ),
                      TextFormField(
                        controller: _emailController,
                        decoration: _estiloInput('E-mail (login)'),
                        style: TextStyle(
                          color: Color.from(
                            alpha: 1.0,
                            red: 0.13,
                            green: 0.59,
                            blue: 0.95,
                          ),
                          fontFamily: AppFonts.mairy,
                        ),
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
                      //if (!_dadosForm.isEmpty) Text('erro'),
                      //const SizedBox(height: 20),
                      TextFormField(
                        decoration: _estiloInput('Senha'),
                        style: TextStyle(
                          color: Color.from(
                            alpha: 1.0,
                            red: 0.13,
                            green: 0.59,
                            blue: 0.95,
                          ),
                          fontFamily: AppFonts.mairy,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true, //nao mostra caracteres
                        controller: _passwordController,
                        onSaved: (password) =>
                            _dadosForm['password'] = password ?? '',
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
                          decoration: _estiloInput('Confirmar Senha'),
                          style: TextStyle(
                            color: Color.from(
                              alpha: 1.0,
                              red: 0.13,
                              green: 0.59,
                              blue: 0.95,
                            ),
                            fontFamily: AppFonts.mairy,
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

                      //const Spacer(),
                      const SizedBox(height: 20),
                      if (_isLoading)
                        const CircularProgressIndicator()
                      else
                        BotaoLogin(
                          texto: _ehLogin() ? 'Acessar' : 'Novo Cadastro',
                          onPressed: () {
                            print('pressiona submit');
                            _submit();
                          },
                          estiloPrimario: true,
                        ),
                      //const SizedBox(height: 20),
                      BotaoLogin(
                        texto: _ehLogin()
                            ? 'Criar novo cadastro?'
                            : 'Já tem conta?',
                        onPressed: _trocaModoTela,
                        estiloPrimario: false,
                      ),
                      // Seus widgets aqui
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
