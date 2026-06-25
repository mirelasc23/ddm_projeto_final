import 'package:ddm_projeto_final/provider/usuario_provider.dart';
import 'package:ddm_projeto_final/widgets/navbar.dart';
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
  int paginaSelecionada = 0;

  void selecionarPagina(int outraPaginaSelecionada){
    setState(() {
      paginaSelecionada = outraPaginaSelecionada;
    });
  }

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<UsuarioProvider>(context, listen: false);

    provider.carregaPessoas();
  }

  @override
  Widget build(BuildContext context) {
    final tamanhoTela = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titulo),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        width: tamanhoTela.width,
        height: tamanhoTela.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login-fundo.png'), // Imagem Local
            // image: NetworkImage('https://link-da-sua-imagem.com'), // Imagem da Internet
            fit: BoxFit.cover, // Garante que a imagem cubra toda a tela
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
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
          ),
        ),
      ),
      bottomNavigationBar: Navbar(
        paginaSelecionada: paginaSelecionada,
        aoSelecionarPagina: selecionarPagina,
      ),
    );
  }
}
