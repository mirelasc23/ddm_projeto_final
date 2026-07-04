import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocalizacaoPage {
  Position? _posicao;
  String _posicaoAtual = "Pressione o botão para buscar a localização";

  Position? get posicao => _posicao;

  Future<void> pegarLocalizacao() async {
    /*bool servicoAtivado;
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
    }*/

    try {
      //Position _posicao = await Geolocator.getCurrentPosition(
      /*_posicao = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );*/

      // 1. Tenta pegar a última localização conhecida (geralmente mais estável se o celular não se moveu)
      Position? lastKnown = await Geolocator.getLastKnownPosition();

      if (lastKnown != null) {
        _posicao = lastKnown;
      } else {
        // 2. Se não houver cache, aí sim busca a atual
        _posicao = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        );
      }

      _posicaoAtual =
          'Latitude: ${_posicao!.latitude}\nLongitude: ${_posicao!.longitude}';
    } catch (e) {
      _posicaoAtual = 'Erro ao buscar localização: $e';
    }
    print(_posicaoAtual);
  }
}
