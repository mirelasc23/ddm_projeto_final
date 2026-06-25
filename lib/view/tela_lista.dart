import 'package:ddm_projeto_final/provider/usuario_provider.dart';
//import 'package:ddm_projeto_final/util/rotas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaLista extends StatefulWidget {
  final String titulo;

  const TelaLista({super.key, required this.titulo});

  @override
  State<TelaLista> createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<UsuarioProvider>(context, listen: false);

    provider.carregaPessoas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              //Navigator.pushNamed(context, Rotas.telaForm);
              print('BOTAO PRESSIONADO');
            },
            tooltip: 'adicionar usuario',
            child: const Icon(Icons.add_box_rounded),
          ),
        ],
      ),
    );
  }
}
