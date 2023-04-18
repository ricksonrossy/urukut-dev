import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:urukut/service/verificacao.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'Roboto-Medium',
      useMaterial3: false,
      primarySwatch: Colors.teal,
      //brightness: Brightness.light,
    ),
    home: const verificacaoUsuario(),
  ));
}
