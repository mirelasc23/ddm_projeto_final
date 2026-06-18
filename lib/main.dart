import 'package:ddm_projeto_final/view/tela_lista.dart';
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
      home: TelaLista(titulo: 'Lista Pessoas'),
    );
  }
}
