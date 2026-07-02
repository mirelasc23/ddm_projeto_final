import 'package:ddm_projeto_final/model/model.dart';

class Acesso implements Model {
  final String uid;
  final String nome;
  final String email;
  final String idToken;
  final String refreshToken;
  final DateTime expiraEm;

  Acesso({
    required this.uid,
    required this.nome,
    required this.email,
    required this.idToken,
    required this.refreshToken,
    required this.expiraEm,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': uid,
      'nome': nome,
      'email': email,
      'id_token': idToken,
      'refresh_token': refreshToken,
      'expira_em': expiraEm.toIso8601String(),
    };
  }

  bool get precisaDeRefresh =>
      DateTime.now().isAfter(expiraEm.subtract(const Duration(minutes: 5)));

  @override
  String toString() {
    return 'Acesso{id: $idToken, nome: $nome, email: $email}';
  }

  @override
  int? id;
}
