import 'package:ddm_projeto_final/provider/usuario_provider.dart';
//import 'package:ddm_projeto_final/util/rotas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaLista_v01 extends StatefulWidget {
  final String titulo;

  const TelaLista_v01({super.key, required this.titulo});

  @override
  State<TelaLista_v01> createState() => _TelaListaState();
}

class _TelaListaState extends State<TelaLista_v01> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<UsuarioProvider>(context, listen: false);

    // provider.carregaPessoas();
  }

  /*void _deleta() {
    if (!(_endereco == null || _nomeController.text.isEmpty)) {
      _endereco!.complemento = _complementoController.text;
      _endereco!.numero = _numeroController.text;
      _usuario = Pessoa(nome: _nomeController.text, endereco: _endereco!);
      final provider = Provider.of<PessoaProvider>(context, listen: false);
      provider.addPessoa(_usuario!);
      Navigator.pop(context);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UsuarioProvider>(context);
    final usuarios = provider.usuarios;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          final usuario = usuarios[index];
          return Card(
            elevation: 3,
            color: Colors.lightBlue[200],
            child: ListTile(
              title: Text(
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                usuario.nome,
              ),
              subtitle: Text(
                style: TextStyle(fontSize: 20),
                "email: ${usuario.nome}",
              ),
              trailing: IconButton(
                onPressed: () => provider.removeUsuario(usuario.id!.toInt()),
                icon: Icon(Icons.delete, color: Colors.red[400]),
              ),
              tileColor: Colors.grey[400],
              onTap: () {
                /*Navigator.pushNamed(
                    context,
                    Rotas.telaDetalhes,
                    arguments: usuario,
                  );*/
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.pushNamed(context, Rotas.telaForm);
        },
        tooltip: 'adicionar usuario',
        child: const Icon(Icons.add_box_rounded),
      ),
    );
  }
}
