import 'package:ddm_projeto_final/util/fontes.dart';
import 'package:ddm_projeto_final/widgets/caixa_texto.dart';
import '../provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormPerfil extends StatefulWidget {
  const FormPerfil({Key? key}) : super(key: key);

  @override
  State<FormPerfil> createState() => _FormPerfilState();
}

class _FormPerfilState extends State<FormPerfil> {
  final _metaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _salvando = false;

  @override
  void initState() {
    super.initState();
    _carregarMeta();
  }

  Future<void> _carregarMeta() async {
    final prefs = await SharedPreferences.getInstance();
    final meta = prefs.getInt('meta_agua') ?? 2500;
    setState(() {
      _metaController.text = meta.toString();
    });
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _salvando = true);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('meta_agua', int.parse(_metaController.text));

    setState(() => _salvando = false);

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Meta salva com sucesso!')));
    }
  }

  @override
  void dispose() {
    _metaController.dispose();
    super.dispose();
  }

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
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 148, 186, 1.0),
                          shape: BoxShape.circle,
                        ),
                        child: const CircleAvatar(
                          radius: 75.0,
                          backgroundImage: AssetImage(
                            'assets/images/foto-perfil.png',
                          ),
                        ),
                      ),
                      caixaTextoExibicao('Nome', acesso!.nome),
                      caixaTextoExibicao('Email', acesso.email),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Meta de água (mL)',
                          style: TextStyle(
                            fontFamily: AppFonts.mairy,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _metaController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '2500',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Informe a meta de água';
                          }
                          final meta = int.tryParse(value);
                          if (meta == null || meta <= 0) {
                            return 'Informe um valor válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _salvando ? null : _salvar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFC107),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 3,
                          ),
                          child: _salvando
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Salvar',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
