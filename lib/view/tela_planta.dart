import 'package:ddm_projeto_final/widgets/form_perfil.dart';
import 'package:flutter/material.dart';

class TelaPlanta extends StatelessWidget {
  const TelaPlanta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tamanhoTela = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: tamanhoTela.width,
        height: tamanhoTela.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tela-perfil.png'),
            fit: BoxFit.cover, 
          ),
        ),
        child: const FormPerfil(),
      ),
    );
  }
}