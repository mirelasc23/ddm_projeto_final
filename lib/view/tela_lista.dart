import 'package:ddm_projeto_final/model/planta.dart';
import 'package:ddm_projeto_final/provider/planta_provider.dart';
import 'package:ddm_projeto_final/util/rotas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaLista extends StatelessWidget {
  final String titulo;

  const TelaLista({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    final tamanhoTela = MediaQuery.of(context).size;
    final List<Planta> plantas = Provider.of<PlantaProvider>(context).plantas;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,

      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Container(
        width: tamanhoTela.width,
        height: double.infinity,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/paginainicial-fundo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, Rotas.telaPerfil);
                },
                icon: Image.asset(
                  'assets/images/imagem_plantar.png',
                  width: 24,
                  height: 24,
                ),
                label: Text('Clique Aqui'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),*/
              Text("Plantas Cadastradas"),
              Expanded(
                child: ListView.builder(
                  //shrinkWrap:
                  //true, // 💡 Faz o ListView ocupar só o tamanho dos itens
                  //physics:
                  //const NeverScrollableScrollPhysics(), // 💡 Desativa a rolagem interna do ListView
                  itemCount: plantas.length,
                  itemBuilder: (context, index) {
                    final planta = plantas[index];
                    //return PlantaCardSheet(planta: planta).build(context);
                    return Card(
                      elevation: 3,
                      color: const Color.fromRGBO(255, 255, 255, 0.53),
                      child: ListTile(
                        title: Text(
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          planta.nome,
                        ),
                        leading: Text("${planta.id}"),
                        //subtitle: ShowDatePicker(tarefa.dataPrevista as Date),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Rotas.telaPlanta,
                              arguments: planta,
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                        //tileColor: tarefa.estaFeliz ? Colors.green[300] : Colors.red[300] ,
                        //subtitle: Text(tarefa.estaFeliz ? "Está feliz :)" : "Está triste :("),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            //Rotas.tarefaDetalhada,
                            Rotas.telaPlanta,
                            arguments: planta,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
