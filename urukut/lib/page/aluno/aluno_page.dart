import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urukut/page/aluno/listpage_aluno.dart';
import 'addpage_aluno.dart';

class alunoPage extends StatelessWidget {
  const alunoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alunos'),
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
                    Icons.group_add_rounded,
                    color: Colors.deepPurple,
                    size: 90.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddPageAluno(),
                        ),
                      );
                    },
                    child: Text('Adicionar Aluno',
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.black)),
                  )
                ],
              )),
            ),
          ),

          //ALUNOS CADASTRADOS

          Card(
            margin: EdgeInsets.all(5.0),
            child: InkWell(
              child: Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.list_alt_outlined,
                    color: Colors.deepOrange,
                    size: 90.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListPageAluno(),
                        ),
                      );
                    },
                    child: Text('Lista de Alunos',
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
