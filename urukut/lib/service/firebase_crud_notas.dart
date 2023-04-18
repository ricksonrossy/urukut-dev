import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urukut/models/notas_models/responseNotas.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Notas');

class FirebaseCrudNotas {

  static Future<ResponseN> addNotas({
    required String newAluno,
    required String newNomeAvaliacao,
    required String NotaUm,
    required String NotaDois,
    required String NotaTres,
  }) async {
    ResponseN response = ResponseN();
    DocumentReference documentReferencer = _Collection.doc(newAluno);

    Map<String, dynamic> data = <String, dynamic>{
      "newAluno": newAluno,
      "newNomeAvaliacao": newNomeAvaliacao,
      "NotaUm": NotaUm,
      "NotaDois": NotaDois,
      "NotaTres": NotaTres,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200; //Code: sucesso
      response.message = "Adicionado com Sucesso!";
    }).catchError((e) {
      response.code = 500; //Code: Erro
      response.message = e;
    });
    return response;
  }

  static Stream<QuerySnapshot> readNotas() {
    CollectionReference notesItemCollection = _Collection;

    return notesItemCollection.snapshots();
  }

  static Future<ResponseN> updateNotas({
    required String newAluno,
    required String newNomeAvaliacao,
    required String NotaUm,
    required String NotaDois,
    required String NotaTres,
    required String docId,

  }) async {
    ResponseN response = ResponseN();
    DocumentReference documentReferencer = _Collection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "newAluno": newAluno,
      "newNomeAvaliacao": newNomeAvaliacao,
      "NotaUm": NotaUm,
      "NotaDois": NotaDois,
      "NotaTres": NotaTres,
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Nota com Sucesso!";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Future<ResponseN> deleteNotas({
    required String docId,
  }) async {
    ResponseN response = ResponseN();
    DocumentReference documentReferencer = _Collection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Nota Deletada com Sucesso!";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
