import 'package:flutter/material.dart';
import 'package:urukut/models/disciplina_models/disciplina.dart';
import 'package:urukut/page/disciplina/listpage_disciplina.dart';
import 'package:urukut/service/firebase_crud_disciplina.dart';

class EditPageDisciplina extends StatefulWidget {
  final Disciplina? disciplina;
  EditPageDisciplina({this.disciplina});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPageDisciplina();
  }
}

class _EditPageDisciplina extends State<EditPageDisciplina> {
  final _nomeDisciplia = TextEditingController();
  final _diasDeAula = TextEditingController();

  final _docid = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool saved = false;

  @override
  void initState() {
    // TODO: implement initState
    _docid.value = TextEditingValue(text: widget.disciplina!.uid.toString());

    _nomeDisciplia.value =
        TextEditingValue(text: widget.disciplina!.nomeDisciplina.toString());
    _diasDeAula.value =
        TextEditingValue(text: widget.disciplina!.diasDeAula.toString());
  }

  @override
  Widget build(BuildContext context) {
    final DocIDField = TextField(
        controller: _docid,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Id-Disciplina",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final nameField = TextFormField(
        controller: _nomeDisciplia,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Sua Disciplina",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final diasField = TextFormField(
        controller: _diasDeAula,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Dias de Aula",
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
          saved = true;
          if (_formKey.currentState!.validate()) {
            var response = await FirebaseCrudDisciplina.updateDisciplina(
                nomeDisciplina: _nomeDisciplia.text,
                diasDeAula: _diasDeAula.text,
                docId: _docid.text);

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
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => ListPageDisciplina())));
        },
        child: Text(
          "Atualizar Discipĺina",
          style: TextStyle(color: Colors.white, fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ),
    );

    final viewListbutton = TextButton(
        onPressed: () {
          saved = true;
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => ListPageDisciplina(),
            ),
            (route) => true,
          );
        },
        child: const Text(
          'Visualizar Disciplinas Cadastradas',
          style: TextStyle(fontSize: 17),
        ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Editar Disciplina',
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //DocIDField,
                  //const SizedBox(height: 25.0),
                  nameField,
                  const SizedBox(height: 25.0),
                  diasField,
                  const SizedBox(height: 25.0),

                  SaveButon,
                  const SizedBox(height: 15.0),
                  viewListbutton,
                  const SizedBox(height: 45.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
