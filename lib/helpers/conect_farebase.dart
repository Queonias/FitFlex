import 'package:cloud_firestore/cloud_firestore.dart';

class FarebaseDB {
  Future<List<DocumentSnapshot>> buscarExercicios(String target) async {
    try {
      // Realiza a consulta no Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('exercicios')
          .where('bodyPart', isGreaterThanOrEqualTo: target)
          .where('bodyPart', isLessThanOrEqualTo: '$target\uf8ff')
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
}
