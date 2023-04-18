import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urukut/page/login/login_page.dart';

class verificacaoUsuario extends StatefulWidget {
  const verificacaoUsuario({super.key});

  @override
  State<verificacaoUsuario> createState() => _verificacaoUsuarioState();
}

class _verificacaoUsuarioState extends State<verificacaoUsuario> {
  StreamSubscription? streamSubscription;

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        //Não têm usuário ativo
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => loginPage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => loginPage(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streamSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
