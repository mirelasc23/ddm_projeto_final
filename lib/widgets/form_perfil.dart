import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:ddm_projeto_final/util/rotas.dart';
import 'package:ddm_projeto_final/util/util.dart';
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

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final acesso = authProvider.acessoAtual;
    //final tamanhoTela = MediaQuery.of(context).size;

    return Container(
      //height: tamanhoTela.height,
      padding: const EdgeInsets.all(30),
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
                    //spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(
                          4.0,
                        ), // Espessura da borda
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(
                            255,
                            148,
                            186,
                            1.0,
                          ), // Cor da borda
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 75.0,
                          backgroundImage: AssetImage(
                            'assets/images/foto-perfil.png',
                          ),
                        ),
                      ),
                      caixaTextoExibicao('Nome', acesso!.nome),
                      caixaTextoExibicao('Email', acesso.email),
                      TextFormField(
                        decoration: Util.estiloInput('Meta'),
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
                        onSaved: (password) =>
                            _dadosForm['password'] = password ?? '',
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
                          decoration: Util.estiloInput('Confirmar Senha'),
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
          },
        ),
      ),
    );
  }
}
