import 'package:geolocator/geolocator.dart';

class LocalizacaoPage {
  Position? _posicao;
  String _posicaoAtual = "Pressione o botão para buscar a localização";

  Position? get posicao => _posicao;

  Future<void> pegarLocalizacao() async {
    bool servicoAtivado;
    LocationPermission permissao;

    servicoAtivado = await Geolocator.isLocationServiceEnabled();
    if (!servicoAtivado) {
      _posicaoAtual = 'Serviços de localização estão desativados.';
      return;
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        _posicaoAtual = 'Permissões de localização foram negadas.';
        return;
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      _posicaoAtual = 'Permissões negadas permanentemente.';
      return;
    }

    try {
      _posicao = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      _posicaoAtual =
          'Latitude: ${_posicao!.latitude}\nLongitude: ${_posicao!.longitude}';
    } catch (e) {
      _posicaoAtual = 'Erro ao buscar localização: $e';
    }
    print(_posicaoAtual);
  }
}
