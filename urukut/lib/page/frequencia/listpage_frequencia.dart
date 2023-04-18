import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urukut/models/frequencia_models/frequencia.dart';
import 'package:urukut/page/frequencia/page_lancarfrequencia.dart';
import 'package:urukut/page/home/home_page.dart';
import 'package:urukut/service/firebase_crud_frequencia.dart';

class ListPageFrequencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListPageFrequencia();
  }
}

class _ListPageFrequencia extends State<ListPageFrequencia> {
  final Stream<QuerySnapshot> collectionReference =
      FirebaseCrudFrequencia.readFrequencia();
  //contador ++ aqui

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Frequência"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
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
                    ListTile(
                      title: Text(e["aluno"]),
                      subtitle: Container(
                        child: (Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Faltas: " + e['falta'],
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
                          child: const Text('Lançar Frequencia'),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil<dynamic>(
                                context,
                                MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) =>
                                      PageLancarFrequencia(
                                    frequencia: Frequencia(
                                      uid: e.id,
                                      aluno: e["aluno"],
                                      falta: e["falta"],
                                    ),
                                  ),
                                ),
                                (route) => true);
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
