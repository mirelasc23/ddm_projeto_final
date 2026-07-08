import 'package:ddm_projeto_final/model/planta.dart';
import 'package:ddm_projeto_final/provider/planta_provider.dart';
import 'package:ddm_projeto_final/util/rotas.dart';
import 'package:ddm_projeto_final/widgets/planta_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  bool _inicializado = false;

  @override
  void initState() {
    super.initState();
    _buscarDadosIniciais();
  }

  Future<void> _buscarDadosIniciais() async {
    final provider = Provider.of<PlantaProvider>(context, listen: false);
    await provider.carregarPlantas();

    if (mounted) {
      setState(() {
        _inicializado = true; // Avisa que a primeira carga do banco terminou
      });
    }
  }

  /*void _abrirCardPlanta(BuildContext context, Planta planta) {
    PlantaCardSheet.mostrar(context, planta);
  }*/

  @override
  Widget build(BuildContext context) {
    //Position posicao = ModalRoute.of(context)?.settings.arguments as Position;
    Position posicao = ModalRoute.of(context)?.settings.arguments as Position;
    final provider = Provider.of<PlantaProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Mapa com OpenStreetMap')),
      body: !_inicializado
          ? const Center(
              child: CircularProgressIndicator(),
            ) // Mostra um carregando enquanto o banco não responde
          : Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(posicao.latitude, posicao.longitude),
                  initialZoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'brotinho.ddm.ifsc',
                  ),
                  MarkerLayer(
                    markers: provider.plantas.map((planta) {
                      return Marker(
                        point: LatLng(planta.lat, planta.long),
                        child: GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, Rotas.telaPlanta),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton(
                backgroundColor: Colors.orangeAccent,
                onPressed: () {
                  // Ação do seu botão aqui (ex: voltar para home, centralizar mapa, etc)
                  print("Botão do mapa pressionado!");
                  Navigator.pushNamed(context, Rotas.telaLista);
                },
                child: const Icon(Icons.list, color: Colors.white),
              ),
            ),
            ]
          ),
    );
  }
}
