import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urukut/page/disciplina/addpage_disciplina.dart';
import 'package:urukut/page/disciplina/listpage_disciplina.dart';

class disciplinaPage extends StatelessWidget {
  const disciplinaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disciplinas'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          Card(
            margin: EdgeInsets.all(5.0),
            child: InkWell(
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.book_outlined,
                    color: Colors.indigo,
                    size: 90.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddPageDisciplina(),
                        ),
                      );
                    },
                    child: Text('Adicionar Disciplina',
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.black)),
                  )
                ],
              )),
            ),
          ),

          //PROFESSORES CADASTRADOS

          Card(
            margin: EdgeInsets.all(5.0),
            child: InkWell(
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.list_alt_outlined,
                    color: Colors.black,
                    size: 90.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListPageDisciplina(),
                        ),
                      );
                    },
                    child: Text('Suas Disciplinas',
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.black)),
                  )
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
