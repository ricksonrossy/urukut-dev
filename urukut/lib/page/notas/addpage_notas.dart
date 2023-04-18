import 'package:flutter/material.dart';
import 'package:urukut/models/notas_models/notas.dart';
import 'package:urukut/page/home/home_page.dart';
import 'package:urukut/page/notas/listpage_notas.dart';
import 'package:urukut/service/firebase_crud_notas.dart';

class AddPageNotas extends StatefulWidget {
  final Notas? notas;
  AddPageNotas({this.notas});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPageNotas();
  }
}

class _AddPageNotas extends State<AddPageNotas> {
  final _newAluno = TextEditingController();
  final _newNomeAvaliacao = TextEditingController();
  final _NotaUm = TextEditingController();
  final _NotaDois = TextEditingController();
  final _NotaTres = TextEditingController();

  final _docid = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _docid.value = TextEditingValue(text: widget.notas!.uid.toString());

    _newAluno.value = TextEditingValue(text: widget.notas!.newAluno.toString());
    _newNomeAvaliacao.value =
        TextEditingValue(text: widget.notas!.newNomeAvaliacao.toString());
    _NotaUm.value = TextEditingValue(text: widget.notas!.NotaUm.toString());
    _NotaDois.value = TextEditingValue(text: widget.notas!.NotaDois.toString());
    _NotaTres.value = TextEditingValue(text: widget.notas!.NotaTres.toString());
  }

  @override
  Widget build(BuildContext context) {
    final DocIDField = TextField(
        controller: _docid,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final newAlunoField = TextFormField(
        controller: _newAluno,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nome do Aluno",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final newNomeAvaliacaoField = TextFormField(
        controller: _newNomeAvaliacao,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nome da Avaliação",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final Nota1Field = TextFormField(
        controller: _NotaUm,
        keyboardType: TextInputType.number,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nota do Aluno",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final Nota2Field = TextFormField(
        controller: _NotaDois,
        keyboardType: TextInputType.number,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nota do Aluno",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final Nota3Field = TextFormField(
        controller: _NotaTres,
        keyboardType: TextInputType.number,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nota do Aluno",
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
            var response = await FirebaseCrudNotas.updateNotas(
                newAluno: _newAluno.text,
                newNomeAvaliacao: _newNomeAvaliacao.text,
                NotaUm: _NotaUm.text,
                NotaDois: _NotaDois.text,
                NotaTres: _NotaTres.text,
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
              MaterialPageRoute(builder: ((context) => ListPageNotas())));
        },
        child: Text(
          "Lançar Nota",
          style: TextStyle(color: Colors.white, fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ),
    );

    final viewListbutton = TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => homePage(),
            ),
            (route) => true,
          );
        },
        child: const Text(
          'Home',
          style: TextStyle(fontSize: 16),
        ));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Lançar Nota',
          style: TextStyle(color: Colors.white),
        ),
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
                  //DocIDField,
                  //const SizedBox(height: 25.0),
                  newAlunoField,
                  const SizedBox(height: 25.0),
                  newNomeAvaliacaoField,
                  const SizedBox(height: 25.0),
                  Nota1Field,
                  const SizedBox(height: 25.0),
                  Nota2Field,
                  const SizedBox(height: 25.0),
                  Nota3Field,
                  const SizedBox(height: 25.0),

                  SaveButon,
                  const SizedBox(height: 10.0),
                  //viewListbutton,
                  //const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
