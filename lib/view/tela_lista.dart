import 'package:ddm_projeto_final/model/acesso.dart';
import 'package:ddm_projeto_final/providers/pessoa_provider.dart';
import 'package:ddm_projeto_final/util/rotas.dart';
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
    final provider = Provider.of<PessoaProvider>(context, listen: false);

    provider.carregaPessoas();
  }

  /*void _deleta() {
    if (!(_endereco == null || _nomeController.text.isEmpty)) {
      _endereco!.complemento = _complementoController.text;
      _endereco!.numero = _numeroController.text;
      _pessoa = Pessoa(nome: _nomeController.text, endereco: _endereco!);
      final provider = Provider.of<PessoaProvider>(context, listen: false);
      provider.addPessoa(_pessoa!);
      Navigator.pop(context);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PessoaProvider>(context);
    final pessoas = provider.pessoas;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      body: ListView.builder(
          itemCount: pessoas.length,
          itemBuilder: (context, index) {
            final pessoa = pessoas[index];
            return Card(
              elevation: 3,
              color: Colors.lightBlue[200],
              child: ListTile(
                title: Text(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold) ,
                  pessoa.nome),
                subtitle: Text(style: TextStyle(fontSize: 20), "cidade: ${pessoa.endereco.cidade}"),
                trailing: IconButton(
                  onPressed: () => provider.removePessoa(pessoa.id!), 
                  icon: Icon(Icons.delete, color: Colors.red[400],)
                ),
                tileColor: Colors.grey[400] ,
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Rotas.telaDetalhes,
                    arguments: pessoa,
                  );
                },
              ),
            );
          },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, Rotas.telaForm);
        },
        tooltip: 'adicionar pessoa',
        child: const Icon(Icons.add_box_rounded),
      )
    );
  }
}
  