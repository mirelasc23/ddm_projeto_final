// import 'package:flutter/painting.dart';
// import 'package:ddm_projeto_final/model/model.dart';

// class Regiao implements Model{
//   int? _id;
//   final String nome;
//   final String imagemFundo;
//   final double latMin, latMax, longMin, longMax;

//   Regiao({
//     int? id,
//     required this.nome,
//     required this.imagemFundo,
//     required this.latMin,
//     required this.latMax,
//     required this.longMin,
//     required this.longMax,
//   });

//   double get latCentral => (latMin + latMax) / 2;
//   double get longCentral => (longMin + longMax) / 2;

//   bool coordenada(double lat, double long) {
//     return lat >= latMin && lat <= latMax && long >= longMin && long <= longMax;
//   }

// //converter coordenadas reais em posicao percentual na imagem estatica
//   Offset coordenadaParaPosicao(double lat, double long) {
//     final x = (long - longMin) / (longMax - longMin);
//     final y = 1 - ((lat - latMin) / (latMax - latMin)); //y invertido
//     return Offset(x.clamp(0, 1), y.clamp(0, 1));
//   }
  
//   @override
//   set id(int id) {
//     _id = id;
//   }

//   @override
//   int? get id => _id;
  
//   @override
//   Map<String, dynamic> toMap() {
//     return{
//       if(id != null)
//       'id' : _id,
//       'nome': nome,
//       'imagemFundo': imagemFundo,
//       'latMin': latMin,
//       'latMax': latMax,
//       'longMin': longMin,
//       'longMax': longMax,
//     };
//   }

//   factory Regiao.fromMap(Map<String, dynamic> map){
//     return Regiao(
//       id: map['id'] as int?,
//       nome: map['nome'] as String,
//       imagemFundo: map['imagemFundo'] as String,
//       latMin: map['latMin'] as double,
//       latMax: map['latMax'] as double,
//       longMin: map['longMin'] as double,
//       longMax: map['longMax'] as double,
//     );
//   }
// }

import 'package:flutter/painting.dart';
import 'package:ddm_projeto_final/model/planta.dart';

class Regiao {
  final double latMin, latMax, longMin, longMax;

  const Regiao({
    required this.latMin,
    required this.latMax,
    required this.longMin,
    required this.longMax,
  });

  double get latCentral => (latMin + latMax) / 2;
  double get longCentral => (longMin + longMax) / 2;

  /// Converte coordenada real em posição percentual (0.0–1.0) dentro do mapa
  Offset coordenadaParaPosicao(double lat, double long) {
    final x = (long - longMin) / (longMax - longMin);
    final y = 1 - ((lat - latMin) / (latMax - latMin)); // y invertido
    return Offset(x.clamp(0, 1), y.clamp(0, 1));
  }

  /// Calcula a região (bounding box) a partir das coordenadas das plantas do usuário
  factory Regiao.calcularDePlantas(List<Planta> plantas, {double margem = 0.15}) {
    if (plantas.isEmpty) {
      return const Regiao(latMin: -0.01, latMax: 0.01, longMin: -0.01, longMax: 0.01);
    }

    double latMin = plantas.first.lat;
    double latMax = plantas.first.lat;
    double longMin = plantas.first.long;
    double longMax = plantas.first.long;

    for (final planta in plantas) {
      if (planta.lat < latMin) latMin = planta.lat;
      if (planta.lat > latMax) latMax = planta.lat;
      if (planta.long < longMin) longMin = planta.long;
      if (planta.long > longMax) longMax = planta.long;
    }

    // Evita divisão por zero quando há só 1 planta (ou todas na mesma coordenada)
    const double margemMinima = 0.0005; // ~50 metros
    if ((latMax - latMin).abs() < margemMinima) {
      latMin -= margemMinima;
      latMax += margemMinima;
    }
    if ((longMax - longMin).abs() < margemMinima) {
      longMin -= margemMinima;
      longMax += margemMinima;
    }

    // Margem extra pra plantas não ficarem coladas na borda da tela
    final folgaLat = (latMax - latMin) * margem;
    final folgaLong = (longMax - longMin) * margem;

    return Regiao(
      latMin: latMin - folgaLat,
      latMax: latMax + folgaLat,
      longMin: longMin - folgaLong,
      longMax: longMax + folgaLong,
    );
  }
}