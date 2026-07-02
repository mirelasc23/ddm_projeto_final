import 'package:ddm_projeto_final/model/acesso.dart';
import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:ddm_projeto_final/util/rotas.dart';
import 'package:ddm_projeto_final/widgets/botao_login.dart';
import 'package:ddm_projeto_final/widgets/caixa_texto.dart';
import '../provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Modo { cadastro, login }

class FormPerfil extends StatefulWidget {
  const FormPerfil({Key? key}) : super(key: key);

  @override
  State<FormPerfil> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormPerfil> {
  final _metaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Modo _modo = Modo.login;

  final Map<String, String> _dadosForm = {'email': '', 'password': ''};

  bool _ehLogin() => _modo == Modo.login;
  bool _ehCadastro() => _modo == Modo.cadastro;

  void _trocaModoTela() {
    print("funcao _trocaModoTela");
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
        borderRadius: BorderRadius.circular(100.0), // Cantos arredondados
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
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    //final tamanhoTela = MediaQuery.of(context).size;
    final acesso = authProvider.acessoAtual;

    return Container(
      padding: const EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0), // Espessura da borda
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 148, 186, 1.0), // Cor da borda
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/foto-perfil.png'),
                  // backgroundImage: NetworkImage('https://seusite.com'),
                ),
              ),
              TextFormField(
                initialValue: acesso!.nome,
                readOnly: true,
                enabled: false,
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
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _dadosForm['email'] =
                    email ?? '', //acao de salvar formulario
                validator: (_email) {
                  //validacao
                  final email = _email ?? '';
                  if (!email.contains('@')) {
                    return 'Informe um e-mail válido.'; //com erro, com essa mensagem
                  }
                  return null;
                },
              ),
              caixaTextoExibicao('Nome', acesso!.nome),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3.0),
                  borderRadius: BorderRadius.circular(100.0), // Raio dos cantos
                ),
                child: Text('Email: ${acesso!.email}'),
              ),
              caixaTextoExibicao('Email', acesso!.email),
              //const SizedBox(height: 20),
              TextFormField(
                decoration: _estiloInput('Meta'),
                style: TextStyle(
                  color: Color.from(
                    alpha: 1.0,
                    red: 0.13,
                    green: 0.59,
                    blue: 0.95,
                  ),
                  fontFamily: AppFonts.mairy,
                ),
                keyboardType: TextInputType.number,
                controller: _metaController,
                onSaved: (password) => _dadosForm['password'] = password ?? '',
                validator: (_meta) {
                  final password = _meta ?? '';
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
                      : (_meta) {
                          final password = _meta ?? '';
                          //por isso precisa definir o controller da senha, para comparar as senhas
                          if (password != _metaController.text) {
                            return 'Senhas informadas diferentes.';
                          }
                          return null;
                        },
                ),
              const SizedBox(height: 20),
              BotaoLogin(
                texto: 'Salvar',
                onPressed: _trocaModoTela,
                estiloPrimario: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
