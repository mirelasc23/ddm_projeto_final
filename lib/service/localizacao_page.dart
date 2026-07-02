import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocalizacaoPage extends StatefulWidget {
  @override
  _LocalizacaoPageState createState() => _LocalizacaoPageState();
}

class _LocalizacaoPageState extends State<LocalizacaoPage> {
  String _posicaoAtual = "Pressione o botão para buscar a localização";

  Future<void> _pegarLocalizacao() async {
    bool servicoAtivado;
    LocationPermission permissao;

    // 1. Verifica se o serviço de localização está ativado no celular
    servicoAtivado = await Geolocator.isLocationServiceEnabled();
    if (!servicoAtivado) {
      setState(() {
        _posicaoAtual = 'Serviços de localização estão desativados.';
      });
      return;
    }

    // 2. Verifica as permissões de acesso
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

    // 3. Pega a localização atual com alta precisão
    try {
      Position posicao = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      setState(() {
        _posicaoAtual = 'Latitude: ${posicao.latitude}\nLongitude: ${posicao.longitude}';
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
                onPressed: _pegarLocalizacao,
                child: const Text('Obter Localização'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
