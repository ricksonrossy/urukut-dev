import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urukut/models/aluno_models/aluno.dart';
import 'package:urukut/page/aluno/addpage_aluno.dart';
import 'package:urukut/page/aluno/editpage_aluno.dart';
import 'package:urukut/page/home/home_page.dart';
import 'package:urukut/service/firebase_crud_aluno.dart';
import 'package:urukut/service/firebase_crud_frequencia.dart';
import 'package:urukut/service/firebase_crud_notas.dart';

class ListPageAluno extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListPageAluno();
  }
}

class _ListPageAluno extends State<ListPageAluno> {
  //late final bool? resizeToAvoidBottomInset;

  final Stream<QuerySnapshot> collectionReference =
      FirebaseCrudAluno.readAluno();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Alunos"),
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
                  builder: (BuildContext context) => AddPageAluno(),
                ),
                (route) =>
                    true, //if you want to disable back feature set to false
              );
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
                    ListTile(
                      title: Text(e['nomeAluno']),
                      subtitle: Container(
                        child: (Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Email: " + e['emailAluno'],
                                style: const TextStyle(fontSize: 14)),
                            Text("Contato: " + e['contatoAluno'],
                                style: const TextStyle(fontSize: 14)),
                            Text("Nascimento: " + e['nascimentoAluno'],
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
                                builder: (BuildContext context) =>
                                    EditPageAluno(
                                  aluno: Aluno(
                                    uid: e.id,
                                    nomeAluno: e["nomeAluno"],
                                    emailAluno: e["emailAluno"],
                                    contatoAluno: e["contatoAluno"],
                                    nascimentoAluno: e["nascimentoAluno"],
                                  ),
                                ),
                              ),
                              (route) =>
                                  false, //if you want to disable back feature set to false
                            );
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5.0),
                            primary: const Color.fromARGB(255, 143, 133, 226),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          child: const Text('Delete'),
                          onPressed: () async {
                            var response = await FirebaseCrudAluno.deleteAluno(
                                docId: e.id);
                            var responseF =
                                await FirebaseCrudFrequencia.deleteFrequencia(
                                    docId: e.id);
                            var responseN = await FirebaseCrudNotas.deleteNotas(
                                docId: e.id);
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
