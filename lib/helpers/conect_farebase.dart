import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FarebaseDB {
  Future<List<DocumentSnapshot>> buscarExercicios(String target) async {
    try {
      // Realiza a consulta no Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('exercicios')
          .where('bodyPart', isGreaterThanOrEqualTo: target)
          .where('bodyPart', isLessThanOrEqualTo: '$target\uf8ff')
          .limit(20)
          .get();

      // Retorna os documentos encontrados
      return querySnapshot.docs;
    } catch (error) {
      // Trata qualquer erro que ocorrer
      print('Erro ao buscar exercícios: $error');
      return [];
    }
  }

  Future<List<DocumentSnapshot>> getAll() async {
    try {
      // Realiza a consulta no Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('exercicios')
          .orderBy('name')
          .get();

      // Retorna os documentos encontrados
      return querySnapshot.docs;
    } catch (error) {
      // Trata qualquer erro que ocorrer
      print('Erro ao buscar exercícios: $error');
      return [];
    }
  }

  Future<String> loadImage(
    String nameFolder,
    String imageName,
  ) async {
    try {
      // Caminho completo para o arquivo de imagem no Firebase Storage
      String path = '$nameFolder/$imageName';

      // Referência para o arquivo de imagem no Firebase Storage
      final storageRef = FirebaseStorage.instance.ref(path);

      // Obtém a URL de download da imagem
      final String downloadUrl = await storageRef.getDownloadURL();

      // Retorna a URL de download da imagem
      return downloadUrl;
    } catch (error) {
      print('Erro ao carregar imagem: $error');
      return ''; // Retorna uma string vazia em caso de erro
    }
  }

  Future<List<DocumentSnapshot>> getExercises(
      {int limit = 10, int startAfterIndex = 0}) async {
    try {
      // Realiza a consulta no Firestore com limite e ponto de partida
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('exercicios')
          .orderBy('name')
          .startAfterDocument((startAfterIndex > 0
              ? await _getDocumentAtIndex(startAfterIndex)
              : null) as DocumentSnapshot<Object?>)
          .limit(limit)
          .get();

      // Retorna os documentos encontrados
      return querySnapshot.docs;
    } catch (error) {
      // Trata qualquer erro que ocorrer
      print('Erro ao buscar exercícios: $error');
      return [];
    }
  }

  Future<QueryDocumentSnapshot<Object?>?> _getDocumentAtIndex(int index) async {
    try {
      // Obtém a referência para a coleção
      CollectionReference exercisesRef =
          FirebaseFirestore.instance.collection('exercicios');

      // Realiza a consulta no Firestore para obter o documento no índice especificado
      QuerySnapshot querySnapshot =
          await exercisesRef.orderBy('name').limit(index).get();

      // Retorna o último documento da consulta
      return querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;
    } catch (error) {
      // Trata qualquer erro que ocorrer
      print('Erro ao obter documento no índice $index: $error');
      return null;
    }
  }
}
