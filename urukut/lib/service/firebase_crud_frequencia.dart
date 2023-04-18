import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urukut/models/frequencia_models/responseFrequencia.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Frequencia');

//db.colletion = _Collection.collection

class FirebaseCrudFrequencia {
//CRUD method here
  static Future<ResponseF> addFrequencia({
    required String aluno,
    required String falta,
  }) async {
    ResponseF response = ResponseF();
    DocumentReference documentReferencer = _Collection.doc(aluno);

    Map<String, dynamic> data = <String, dynamic>{
      "aluno" : aluno,
      "falta" : falta,
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

  static Stream<QuerySnapshot> readFrequencia() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<ResponseF> updateFrequencia({
    required String aluno,
    required String falta,
    required String docId,
  }) async {
    ResponseF response = ResponseF();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "aluno": aluno,
      "falta": falta,
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

  static Future<ResponseF> deleteFrequencia({
    required String docId,
  }) async {
    ResponseF response = ResponseF();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Frequencia Apagada com Sucesso!";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
