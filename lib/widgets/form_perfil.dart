import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:ddm_projeto_final/util/rotas.dart';
import 'package:ddm_projeto_final/widgets/botao_login.dart';
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

  // Estilo padrão reutilizável para deixar os inputs arredondados e claros
  InputDecoration _estiloInput(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      // Cor de fundo clara (pode ajustar para Colors.grey[100] ou similar se preferir)
      fillColor: const Color.fromRGBO(255, 255, 255, 0.53),
      // Borda padrão quando o campo não está focado
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0), // Cantos arredondados
        borderSide: BorderSide.none, // Remove a linha de contorno preta padrão
      ),
      // Borda quando o usuário clica no campo
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0),
        borderSide: const BorderSide(
          color: Color.from(
            alpha: 1.0,
            red: 0.13,
            green: 0.59,
            blue: 0.95,
          ), // Borda azul do seu tema
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tamanhoTela = MediaQuery.of(context).size;

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
                  color: Color.fromRGBO(255, 148,186,1.0), // Cor da borda
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/foto-perfil.png'),
                  // backgroundImage: NetworkImage('https://seusite.com'),
                ),
              ),
              TextFormField(
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
              // LayoutBuilder(
              //   builder: (BuildContext context, BoxConstraints constraints) {
              //     // constraints.maxWidth contém a largura exata do pai
              //     final larguraDoPai = constraints.maxWidth;
                  
              //     return Container(
              //       width: larguraDoPai * 0.5, // Exemplo: 50% da largura do pai
              //       color: Colors.blue,
                    
              //       child: Text('Largura do pai: $larguraDoPai'),
              //     );
              //   },
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.black, width: 3.0),
              //     borderRadius: BorderRadius.circular(12.0), // Raio dos cantos
              //   ),
              //   child: Text('Email'),
              // ),
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
          
              //const Spacer(),
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
