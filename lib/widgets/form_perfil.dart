import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:ddm_projeto_final/util/util.dart';
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

  final Map<String, String> _dadosForm = {'email': '', 'password': ''};

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final acesso = authProvider.acessoAtual;

    return Container(
      padding: const EdgeInsets.all(30),
      child: Form(
        key: _formKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(
                          4.0,
                        ), 
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(
                            255,
                            148,
                            186,
                            1.0,
                          ), 
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
                      const SizedBox(height: 40),
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
                      Tooltip(
                        message: 'Dados salvos localmente no SQLite.',
                        triggerMode:
                            TooltipTriggerMode.tap,
                        preferBelow: false,
                        child: IconButton(
                          icon: const Icon(
                            Icons.info_rounded,
                            color: Colors.red,
                          ),
                          onPressed: null,
                        ),
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
