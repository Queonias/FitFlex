import 'package:academia/telas/menu.dart';
import 'package:academia/telas/login.dart';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Verificação de plataforma para definir configurações de persistência
  if (!kIsWeb) {
    // Configurações para iOS e Android
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: true);
  } else {
    // Configurações para a Web
    await FirebaseFirestore.instance
        .enablePersistence(const PersistenceSettings(synchronizeTabs: true));
  }

  await Firebase.initializeApp();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? usuarioLogado = auth.currentUser;
  Widget initialWidget;
  if (usuarioLogado != null) {
    initialWidget =
        const Menu(); // Redireciona para a tela Home se o usuário estiver logado
  } else {
    initialWidget =
        const Login(); // Exibe a tela de login se o usuário não estiver logado
  }

  runApp(MyApp(initialWidget: initialWidget));
}

class MyApp extends StatefulWidget {
  final Widget initialWidget;
  const MyApp({Key? key, required this.initialWidget}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitFlex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 148, 183)),
        useMaterial3: true,
      ),
      home: widget.initialWidget,
    );
  }
}
