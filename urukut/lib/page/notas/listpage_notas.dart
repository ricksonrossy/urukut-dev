import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urukut/models/notas_models/notas.dart';
import 'package:urukut/page/home/home_page.dart';
import 'package:urukut/page/notas/addpage_notas.dart';
import 'package:urukut/service/firebase_crud_notas.dart';

class ListPageNotas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListPageNotas();
  }
}

class _ListPageNotas extends State<ListPageNotas> {
  //late final bool? resizeToAvoidBottomInset;

  final Stream<QuerySnapshot> collectionReference =
      FirebaseCrudNotas.readNotas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Notas"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          //home-icon
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
                      title: Text(e["newAluno"]),
                      subtitle: Container(
                        child: (Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Disciplina: " + e['newNomeAvaliacao'],
                                style: const TextStyle(fontSize: 14)),
                            Text("Nota 1: " + e['NotaUm'],
                                style: const TextStyle(fontSize: 14)),
                            Text("Nota 2: " + e['NotaDois'],
                                style: const TextStyle(fontSize: 14)),
                            Text("Nota 3: " + e['NotaTres'],
                                style: const TextStyle(fontSize: 14)),

                          ],
                        )),
                      ),
                    ),
                    ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(5.0),
                              primary: const Color.fromARGB(255, 143, 133, 226),
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            child: const Text('+Nota'),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      AddPageNotas(
                                    notas: Notas(
                                      uid: e.id,
                                      newAluno: e['newAluno'],
                                      newNomeAvaliacao: e['newNomeAvaliacao'],
                                      NotaUm: e['NotaUm'],
                                      NotaDois: e['NotaDois'],
                                      NotaTres: e['NotaTres'],
                                    ),
                                  ),
                                ),
                                (route) =>
                                    true, //if you want to disable back feature set to false
                              );
                            },
                          ),
                        ])
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
