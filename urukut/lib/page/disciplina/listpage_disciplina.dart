import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urukut/models/disciplina_models/disciplina.dart';
import 'package:urukut/page/disciplina/addpage_disciplina.dart';
import 'package:urukut/page/disciplina/editpage_disciplina.dart';
import 'package:urukut/service/firebase_crud_disciplina.dart';
import '../home/home_page.dart';

class ListPageDisciplina extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListPageDisciplina();
  }
}

class _ListPageDisciplina extends State<ListPageDisciplina> {
  //late final bool? resizeToAvoidBottomInset;

  final Stream<QuerySnapshot> collectionReference =
      FirebaseCrudDisciplina.readDisciplina();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Suas Disciplinas"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.app_registration,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => AddPageDisciplina(),
                  ),
                  (route) => true);
            },
          ),
          //home
          IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => const homePage())));
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: collectionReference,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: snapshot.data!.docs.map((e) {
                  return Card(
                      child: Column(children: [
                    //chama o documento de cada perfil para ser visto
                    ListTile(
                      title: Text(e["nomeDisciplina"]),
                      subtitle: Container(
                        child: (Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Dias de Aula: " + e['diasDeAula'],
                                style: const TextStyle(fontSize: 14)),
                          ],
                        )),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            primary: const Color.fromARGB(255, 143, 133, 226),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Editar'),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => EditPageDisciplina(
                                  disciplina: Disciplina(
                                      uid: e.id,
                                      nomeDisciplina: e["nomeDisciplina"],
                                      diasDeAula: e["diasDeAula"]),
                                ),
                              ),
                              (route) =>
                                  true, //if you want to disable back feature set to false
                            );
                          },
                        ),
                        //Fim botão editar
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            primary: const Color.fromARGB(255, 143, 133, 226),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Delete'),
                          onPressed: () async {
                            var response =
                                await FirebaseCrudDisciplina.deleteDisciplina(docId: e.id);
                            if (response.code != 200) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content:
                                          Text(response.message.toString()),
                                    );
                                  });
                            }
                          },
                        ),
                      ],
                    ),
                  ]));
                }).toList(),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
