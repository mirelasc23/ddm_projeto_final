// ambiente_model.dart
class Ambiente {
  final int? id;
  final String nome; // Ex: "Canteiro Central", "Estufa 1"
  final double latitude;
  final double longitude;

  Ambiente({
    this.id,
    required this.nome,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'nome': nome,
    'latitude': latitude,
    'longitude': longitude,
  };

  factory Ambiente.fromMap(Map<String, dynamic> map) => Ambiente(
    id: map['id'],
    nome: map['nome'],
    latitude: map['latitude'],
    longitude: map['longitude'],
  );
}

// planta_model.dart
class Planta {
  final int? id;
  final int ambienteId; // Vínculo com a localização
  final String nome; // Ex: "Samambaia", "Tomateiro"
  final String? ultimaRegagem; // Data formatada em String (ISO8601)

  Planta({
    this.id,
    required this.ambienteId,
    required this.nome,
    this.ultimaRegagem,
  });

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'ambiente_id': ambienteId,
    'nome': nome,
    'ultima_regagem': ultimaRegagem,
  };

  factory Planta.fromMap(Map<String, dynamic> map) => Planta(
    id: map['id'],
    ambienteId: map['ambiente_id'],
    nome: map['nome'],
    ultimaRegagem: map['ultima_regagem'],
  );
}
