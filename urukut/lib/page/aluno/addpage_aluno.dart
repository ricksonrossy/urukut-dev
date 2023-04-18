import 'package:flutter/material.dart';
import 'package:urukut/service/firebase_crud_disciplina.dart';
import 'package:urukut/service/firebase_crud_frequencia.dart';
import 'package:urukut/service/firebase_crud_notas.dart';
import '../../service/firebase_crud_aluno.dart';
import 'listpage_aluno.dart';

class AddPageAluno extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPageAluno();
  }
}

class _AddPageAluno extends State<AddPageAluno> {
  final _nomeAluno = TextEditingController();
  final _emailAluno = TextEditingController();
  final _contatoAluno = TextEditingController();
  final _nascimentoAluno = TextEditingController();

  final _nomeDisciplina = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
        controller: _nomeAluno,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nome do Aluno",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final emailField = TextFormField(
        controller: _emailAluno,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email do Aluno",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final nascimentoField = TextFormField(
        controller: _nascimentoAluno,
        keyboardType: TextInputType.datetime,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Data de Nascimento do Aluno",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final contatoField = TextFormField(
        controller: _contatoAluno,
        keyboardType: TextInputType.phone,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Contato do Aluno",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final disciplinaField = TextFormField(
        controller: _nomeDisciplina,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Disciplina do Aluno",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final SaveButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCrudAluno.addAluno(
                nomeAluno: _nomeAluno.text,
                emailAluno: _emailAluno.text,
                contatoAluno: _contatoAluno.text,
                nascimentoAluno: _nascimentoAluno.text
            );
            await FirebaseCrudFrequencia.addFrequencia(
                aluno: _nomeAluno.text,
                falta: "",
            );
            await FirebaseCrudNotas.addNotas(
                newAluno: _nomeAluno.text,
                newNomeAvaliacao: _nomeDisciplina.text,
                NotaUm: '0',
                NotaDois: '0',
                NotaTres: '0',
            );
            await FirebaseCrudDisciplina.addDiscplina(
                nomeDisciplina: _nomeDisciplina.text,
                diasDeAula: '',
            );

            if (response.code != 200) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(response.message.toString()),
                    );
                  });
            }
          }
        },
        child: Text("Cadastrar Aluno",
            style: TextStyle(color: Colors.white, fontSize: 17),
            textAlign: TextAlign.center),
      ),
    );

    final viewListbutton = TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ListPageAluno(),
            ),
            (route) => true, //To disable back feature set to false
          );
        },
        child: const Text(
          'Visualizar Alunos Cadastrados',
          style: TextStyle(fontSize: 16),
        ));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Cadastre um Aluno',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  nameField,
                  const SizedBox(height: 25.0),
                  emailField,
                  const SizedBox(height: 25.0),
                  nascimentoField,
                  const SizedBox(height: 25.0),
                  contatoField,
                  const SizedBox(height: 25.0),
                  disciplinaField,
                  const SizedBox(height: 25.0),
                  SaveButon,
                  const SizedBox(height: 10.0),
                  viewListbutton,
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
