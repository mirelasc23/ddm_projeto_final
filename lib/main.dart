import 'package:ddm_projeto_final/util/rotas.dart';
import 'package:ddm_projeto_final/view/tela_lista.dart';
import 'package:ddm_projeto_final/view/tela_login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blueGrey),
      ),
      // home: const TelaInicio(title: 'Flutter Demo Home Page'),
      home: TelaLogin(),
      routes: {
          //Rotas.telaDetalhes : (context) => TelaDados(titulo: "Detalhes pessoa"), 
          Rotas.telaBusca : (context) => TelaLista(titulo: 'Lista ex.'),
        },
    );
  }
}
