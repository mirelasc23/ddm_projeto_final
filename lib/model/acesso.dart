class Acesso {
  /*String _idToken;
  final String _nome;
  String _email;*/
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

  /*Acesso({required nome, required email, required idToken}) :
  _email = email,
  _idToken = idToken,
  _nome = nome;*

  // set id(String id) {
  //   _idToken = id;
  // }

  String? get id => _idToken;

  Map<String, dynamic> toMap() {
    return {'id: ': _idToken, ', nome: ': _nome, ', email: ':_email}; //, 'endereco': endereco.toMap()};
  }

  factory Acesso.fromMap(Map<String, dynamic> map) {
    var pessoa = Acesso(
      nome: map['nome'] as String,
      idToken: map['idToken'] as String,
      email: map['email'] as String,
    );
    // pessoa.id = map['id'] as String;
    return pessoa;
  }*/

  bool get precisaDeRefresh =>
      DateTime.now().isAfter(expiraEm.subtract(const Duration(minutes: 5)));

  @override
  String toString() {
    return 'Acesso{id: $idToken, nome: $nome, email: $email}';
  }
}
