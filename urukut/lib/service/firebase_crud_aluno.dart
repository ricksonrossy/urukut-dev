import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urukut/models/aluno_models/responseAluno.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Aluno');

class FirebaseCrudAluno {
  static Future<Response> addAluno({
    required String nomeAluno,
    required String emailAluno,
    required String contatoAluno,
    required String nascimentoAluno,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(nomeAluno);

    Map<String, dynamic> data = <String, dynamic>{
      "nomeAluno": nomeAluno,
      "emailAluno": emailAluno,
      "contatoAluno": contatoAluno,
      "nascimentoAluno": nascimentoAluno,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Aluno Cadastrado com Sucesso!";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readAluno() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<Response> updateAluno({
    required String nomeAluno,
    required String emailAluno,
    required String contatoAluno,
    required String nascimentoAluno,
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "nomeAluno": nomeAluno,
      "emailAluno": emailAluno,
      "contatoAluno": contatoAluno,
      "nascimentoAluno": nascimentoAluno,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Dados atualizados com Sucesso!";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<Response> deleteAluno({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Perfil deletado com Sucesso!";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
