import 'package:flutter/material.dart';

class sobre extends StatefulWidget {
  const sobre({Key? key}) : super(key: key);

  @override
  State<sobre> createState() => _sobreState();
}

class _sobreState extends State<sobre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sobre o Aplicativo Urukut',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Text(
        ""
        "Bem Vindos ao APP, para iniciar, gostariamos de explicar "
        "a Origem do nome do app. Urukut é uma palavra da linguagem Sateré Mawé "
        "onde seu significado é Coruja. A logo ser Coruja, é porque um dia este desenvolvedor "
        "foi a um colégio e viu diversas corujas no armário dos Docentes daquela escola, "
        "então surgiu essa idéia. "
        "Urukut têm a intenção de ser um app que ajude os professores a evitarem o retrabalho ao "
        "preencherem seu diário escolar.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
