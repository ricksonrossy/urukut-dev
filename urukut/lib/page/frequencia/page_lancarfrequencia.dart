import 'package:flutter/material.dart';
import 'package:urukut/models/frequencia_models/frequencia.dart';
import 'package:urukut/page/frequencia/listpage_frequencia.dart';
import 'package:urukut/page/home/home_page.dart';
import 'package:urukut/service/firebase_crud_frequencia.dart';

class PageLancarFrequencia extends StatefulWidget {
  final Frequencia? frequencia ;
  PageLancarFrequencia({this.frequencia});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PageLancarFrequencia();
  }
}
class _PageLancarFrequencia extends State<PageLancarFrequencia> {

  final _aluno = TextEditingController();
  final _falta = TextEditingController();

  final _docid = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    // TODO: implement initState
    _docid.value = TextEditingValue(text: widget.frequencia!.uid.toString());

    _aluno.value = TextEditingValue(text: widget.frequencia!.aluno.toString());
    _falta.value = TextEditingValue(text: widget.frequencia!.falta.toString());
  }

  @override
  Widget build(BuildContext context) {
    final DocIDField = TextField(
        controller: _docid,
        readOnly: true,
        autofocus: false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "ID-Aluno",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final alunoField = TextField(
        controller: _aluno,
        autofocus: false,

        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Aluno",
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

    final faltaField = TextFormField(
        controller: _falta,
        keyboardType: TextInputType.number,
        autofocus: false,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Este campo é obrigatório!';
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: "Faltou?",
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
            var response = await FirebaseCrudFrequencia.updateFrequencia(
                aluno: _aluno.text,
                falta: _falta.text,

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
              MaterialPageRoute(builder: ((context) => ListPageFrequencia())));
        },
        child: const Text(
          "Lançar Falta",
          style: TextStyle(color: Colors.white, fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Lançar Faltas',
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
      //body
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
                  alunoField,
                  const SizedBox(height: 25.0),
                  faltaField,
                  const SizedBox(height: 25.0),

                  SaveButon,
                  const SizedBox(height: 15.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
