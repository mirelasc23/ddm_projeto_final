import 'package:flutter/painting.dart';

class Regiao {
  final String id;
  final String nome;
  final String imagemFundo;
  final double latMin, latMax, longMin, longMax;

  const Regiao({
    required this.id,
    required this.nome,
    required this.imagemFundo,
    required this.latMin,
    required this.latMax,
    required this.longMin,
    required this.longMax,
  });

  double get latCentral => (latMin + latMax) / 2;
  double get longCentral => (longMin + longMax) / 2;

  bool coordenada(double lat, double long) {
    return lat >= latMin && lat <= latMax && long >= longMin && long <= longMax;
  }

//converter coordenadas reais em posicao percentual na imagem estatica
  Offset coordenadaParaPosicao(double lat, double long) {
    final x = (long - longMin) / (longMax - longMin);
    final y = 1 - ((lat - latMin) / (latMax - latMin)); //y invertido
    return Offset(x.clamp(0, 1), y.clamp(0, 1));
  }
}
