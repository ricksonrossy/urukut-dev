import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urukut/page/aluno/aluno_page.dart';
import 'package:urukut/page/disciplina/disciplina_page.dart';
import 'package:urukut/page/frequencia/listpage_frequencia.dart';
import 'package:urukut/page/home/sobre.dart';
import 'package:urukut/page/notas/addpage_notas.dart';
import 'package:urukut/page/notas/listpage_notas.dart';
import '../../service/verificacao.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  //Pegando informações de login para o drawer
  final _firebaseAuth = FirebaseAuth.instance;

  String nomeUser = '';
  String emailAddressUser = '';

  @override
  void initState() {
    // TODO: implement initState
    pegarInfoUsuario();
  }

  pegarInfoUsuario() {
    User? usuario = _firebaseAuth.currentUser;
    if (usuario != null) {
      setState(() {
        // Name, email address, and profile photo URL
        nomeUser = usuario.displayName!;
        emailAddressUser = usuario.email!;
      });
    }
  }
  //FIM!

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Início do AppBar
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Bom Trabalho!',
          style: TextStyle(fontSize: 26),
        ),
      ),
      //Fim do AppBar

      //Temos a parte do drawer, que é a barra de navegação lateral
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            //
            DrawerHeader(
              child: null,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: const AssetImage("lib/assets/background.png"),
                    fit: BoxFit.cover),
              ),
            ),
            ListTile(
              title: Text(
                nomeUser,
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
              ),
              subtitle: Text(
                emailAddressUser,
                style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
              ),
            ),

            ListTile(),

            Image.asset(
              'lib/assets/fordrawer-background.png',
              height: 100,
              width: 100,
            ),
            TextButton(
              style: TextButton.styleFrom(

                padding: const EdgeInsets.all(5.0),
                primary: const Color.fromARGB(255, 2, 0, 9),
                textStyle: const TextStyle(fontSize: 20, ),

              ),
              child: const Text('Sobre o Urukut'),
              onPressed: () {
                Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                          sobre(),
                    ),
                        (route) => true);
              },
            ),
            ListTile(),
            ListTile(
              dense: true,
              title: Text(
                'Sair',
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.exit_to_app_sharp),
              onTap: () {
                sair();
              },
            ),
          ],
        ),
      ),
      //Fim do Drawer

      body: Container(
          padding: EdgeInsets.all(20.0),
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              //CARD 1 - Alunos
              Card(
                margin: EdgeInsets.all(5.0),
                child: InkWell(
                  child: Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.deepPurple,
                        size: 50.0,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => alunoPage(),
                            ),
                          );
                        },
                        child: Text('ALUNOS',
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.black)),
                      )
                    ],
                  )),
                ),
              ),
              //CARD 2 - Disciplina
              Card(
                margin: EdgeInsets.all(5.0),
                child: InkWell(
                  child: Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.class_sharp,
                        color: Colors.deepOrange,
                        size: 50.0,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => disciplinaPage(),
                            ),
                          );
                        },
                        child: Text('DISCIPLINAS',
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.black)),
                      )
                    ],
                  )),
                ),
              ),

              //CARD 3 - Notas
              Card(
                margin: EdgeInsets.all(5.0),
                child: InkWell(
                  child: Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.mode_outlined,
                        color: Colors.black,
                        size: 50.0,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListPageFrequencia(),
                            ),
                          );
                        },
                        child: Text('FREQUÊNCIA',
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.black)),
                      )
                    ],
                  )),
                ),
              ),

              //CARD 4 - Notas
              Card(
                margin: EdgeInsets.all(5.0),
                child: InkWell(
                  child: Center(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.note_alt_outlined,
                        color: Colors.green,
                        size: 50.0,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListPageNotas(),
                            ),
                          );
                        },
                        child: Text('NOTAS',
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.black)),
                      )
                    ],
                  )),
                ),
              ),
            ],
          )),
    );
  }

  sair() async {
    await _firebaseAuth.signOut().then(
          (user) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => verificacaoUsuario(),
            ),
          ),
        );
  }
}
