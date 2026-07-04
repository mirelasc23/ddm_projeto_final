import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocalizacaoPageOriginal extends StatefulWidget {
  @override
  _LocalizacaoPageState createState() => _LocalizacaoPageState();
}

class _LocalizacaoPageState extends State<LocalizacaoPageOriginal> {
  Position? _posicao;
  String _posicaoAtual = "Pressione o botão para buscar a localização";

  Position? get posicao => _posicao;

  Future<void> pegarLocalizacao() async {
    bool servicoAtivado;
    LocationPermission permissao;

    servicoAtivado = await Geolocator.isLocationServiceEnabled();
    if (!servicoAtivado) {
      setState(() {
        _posicaoAtual = 'Serviços de localização estão desativados.';
      });
      return;
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        setState(() {
          _posicaoAtual = 'Permissões de localização foram negadas.';
        });
        return;
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      setState(() {
        _posicaoAtual = 'Permissões negadas permanentemente.';
      });
      return;
    }

    try {
      //Position _posicao = await Geolocator.getCurrentPosition(
      _posicao = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      setState(() {
        _posicaoAtual =
            'Latitude: ${_posicao!.latitude}\nLongitude: ${_posicao!.longitude}';
      });
    } catch (e) {
      setState(() {
        _posicaoAtual = 'Erro ao buscar localização: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exemplo de Geolocalização')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _posicaoAtual,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: pegarLocalizacao,
                child: const Text('Obter Localização'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
