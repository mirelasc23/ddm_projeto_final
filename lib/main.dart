import 'package:ddm_projeto_final/model/acesso.dart';
import 'package:ddm_projeto_final/provider/auth_provider.dart';
import 'package:ddm_projeto_final/provider/rega_provider.dart';
import 'package:ddm_projeto_final/provider/usuario_provider.dart';
import 'package:ddm_projeto_final/util/rotas.dart';
import 'package:ddm_projeto_final/view/tela_login.dart';
import 'package:ddm_projeto_final/view/telas.dart';
import 'package:ddm_projeto_final/view/tela_perfil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  /*runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );*/
  runApp(const MyApp());
}

final getIt = GetIt.instance;

void inicializarObjeto(Acesso acesso) {
  getIt.registerSingleton<Acesso>(acesso);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => UsuarioProvider()),
        ChangeNotifierProvider(create: (context) => RegaProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blueGrey)),
        home: TelaLogin(),
        routes: {
          Rotas.telaInicial:(context) => Telas(),
          Rotas.telaPerfil: (context) => TelaPerfil()
        },
      ),
    );
  }
}