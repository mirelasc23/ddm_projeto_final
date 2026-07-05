// mapa_plantas_page.dart
import 'package:ddm_projeto_final/_proxima_etapa/model.dart';
import 'package:ddm_projeto_final/_proxima_etapa/provider.dart';
import 'package:ddm_projeto_final/provider/planta_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapaPlantasPage extends StatefulWidget {
  @override
  _MapaPlantasPageState createState() => _MapaPlantasPageState();
}

class _MapaPlantasPageState extends State<MapaPlantasPage> {
  @override
  void initState() {
    super.initState();
    // Carrega as localizações assim que a tela abre
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Provider.of<PlantaProvider>(context, listen: false).carregarAmbientes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlantProvider>(context);

    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(-28.0267, -49.1235),
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://openstreetmap.org{z}/{x}/{y}.png',
            userAgentPackageName: 'com.seuapp.plantas',
          ),
          MarkerLayer(
            markers: provider.ambientes.map((ambiente) {
              return Marker(
                point: LatLng(ambiente.latitude, ambiente.longitude),
                child: GestureDetector(
                  onTap: () => _abrirPainelRega(context, ambiente),
                  child: Icon(Icons.location_on, color: Colors.green, size: 40),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Abre o painel contendo as plantas instaladas nessa localização
  void _abrirPainelRega(BuildContext context, Ambiente ambiente) {
    final provider = Provider.of<PlantProvider>(context, listen: false);
    provider.carregarPlantasDoAmbiente(ambiente.id!);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Consumer<PlantProvider>(
          builder: (context, prov, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ambiente.nome,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  // Botão para Regar tudo simultaneamente no ambiente
                  ElevatedButton.icon(
                    icon: Icon(Icons.water_drop),
                    label: Text("Regar todas as plantas deste local"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      await prov.regarTodasDoAmbiente(ambiente.id!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Todas as plantas regadas!")),
                      );
                    },
                  ),
                  Divider(),

                  // Lista de plantas individuais do ambiente
                  Expanded(
                    child: ListView.builder(
                      itemCount: prov.plantasDoAmbienteSelecionado.length,
                      itemBuilder: (context, index) {
                        final planta = prov.plantasDoAmbienteSelecionado[index];
                        return ListTile(
                          title: Text(planta.nome),
                          subtitle: Text(
                            planta.ultimaRegagem == null
                                ? "Nunca regada"
                                : "Última: ${DateTime.parse(planta.ultimaRegagem!).toLocal().toString().substring(0, 16)}",
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.opacity, color: Colors.blue),
                            onPressed: () async {
                              await prov.regarPlantaUnica(
                                planta.id!,
                                ambiente.id!,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
