import 'package:flutter/material.dart';
import '../../models/aluno_models/aluno.dart';
import '../../service/firebase_crud_aluno.dart';
import 'listpage_aluno.dart';

class EditPageAluno extends StatefulWidget {
  final Aluno? aluno;
  EditPageAluno({this.aluno});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPageAluno();
  }
}

class _EditPageAluno extends State<EditPageAluno> {
  final _aluno_name = TextEditingController();
  final _aluno_email = TextEditingController();
  final _aluno_contato = TextEditingController();
  final _aluno_nascimento = TextEditingController();

  final _docid = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _docid.value = TextEditingValue(text: widget.aluno!.uid.toString());

    _aluno_name.value =
        TextEditingValue(text: widget.aluno!.nomeAluno.toString());
    _aluno_email.value =
        TextEditingValue(text: widget.aluno!.emailAluno.toString());
    _aluno_contato.value =
        TextEditingValue(text: widget.aluno!.contatoAluno.toString());
    _aluno_nascimento.value =
        TextEditingValue(text: widget.aluno!.nascimentoAluno.toString());
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

    final nameField = TextFormField(
        controller: _aluno_name,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nome",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final emailField = TextFormField(
        controller: _aluno_email,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final nascimentoField = TextFormField(
        controller: _aluno_nascimento,
        keyboardType: TextInputType.datetime,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Nascimento",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final contatoField = TextFormField(
        controller: _aluno_contato,
        keyboardType: TextInputType.phone,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Contato",
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
            var response = await FirebaseCrudAluno.updateAluno(
                nomeAluno: _aluno_name.text,
                emailAluno: _aluno_email.text,
                contatoAluno: _aluno_contato.text,
                nascimentoAluno: _aluno_nascimento.text,
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
              MaterialPageRoute(builder: ((context) => ListPageAluno())));
        },
        child: Text(
          "Atualizar Aluno",
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
              builder: (BuildContext context) => ListPageAluno(),
            ),
            (route) => true, //if you want to disable back feature set to false
          );
        },
        child: const Text('Lista de Alunos', style: TextStyle(fontSize: 16)));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Editar Aluno'),
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
                  emailField,
                  const SizedBox(height: 25.0),
                  nascimentoField,
                  const SizedBox(height: 35.0),
                  contatoField,
                  const SizedBox(height: 35.0),

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
