import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urukut/models/disciplina_models/responseDisciplina.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Disciplina');

//db.colletion = _Collection.collection

class FirebaseCrudDisciplina {
//CRUD method here
  static Future<Response> addDiscplina({
    required String nomeDisciplina,
    required String diasDeAula,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(nomeDisciplina);

    Map<String, dynamic> data = <String, dynamic>{
      "nomeDisciplina": nomeDisciplina,
      "diasDeAula": diasDeAula,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200; //Code: sucesso
      response.message = "Disciplina Cadastrada com Sucesso!";
    }).catchError((e) {
      response.code = 500; //Code: Erro
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readDisciplina() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> updateDisciplina({
    required String nomeDisciplina,
    required String diasDeAula,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "nomeDisciplina": nomeDisciplina,
      "diasDeAula": diasDeAula,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Dados atualizdos com Sucesso!";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> deleteDisciplina({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Disciplina deletado com Sucesso!";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
