import 'package:ddm_projeto_final/model/planta.dart';
import 'package:ddm_projeto_final/model/rega.dart';
import 'package:ddm_projeto_final/provider/planta_provider.dart';
import 'package:ddm_projeto_final/util/rotas.dart';
import 'package:ddm_projeto_final/widgets/planta_card.dart';
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

      appBar: AppBar(
        title: Text("Plantas Cadastradas"),
        backgroundColor: Colors.transparent,
      ),
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
              //Text("Plantas Cadastradas"),
              Expanded(
                child: ListView.builder(
                  itemCount: plantas.length,
                  itemBuilder: (context, index) {
                    final planta = plantas[index];
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
                        subtitle: // Última rega (busca assíncrona no banco)
                        FutureBuilder<Rega?>(
                          future: PlantaCardSheet.buscarUltimaRega(planta.id!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            }

                            final rega = snapshot.data;
                            if (rega == null) {
                              return Row(
                                children: [
                                  Icon(
                                    Icons.water_drop_outlined,
                                    size: 18,
                                    color: Colors.grey.shade500,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Nenhuma rega registrada',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              );
                            }

                            final data = DateTime.parse(rega.dataRega);
                            final dias = DateTime.now().difference(data).inDays;

                            return Row(
                              children: [
                                const Icon(
                                  Icons.water_drop,
                                  size: 18,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Última rega',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '${data.day.toString().padLeft(2, '0')}/'
                                      '${data.month.toString().padLeft(2, '0')}/'
                                      '${data.year} '
                                      '(há $dias dia${dias == 1 ? '' : 's'})',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
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
