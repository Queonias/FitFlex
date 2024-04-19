import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExercicioList extends StatefulWidget {
  final String title; // Adicionando o parâmetro title
  final String search;

  const ExercicioList({Key? key, required this.title, required this.search})
      : super(key: key);

  @override
  State<ExercicioList> createState() => _ExercicioListState();
}

class _ExercicioListState extends State<ExercicioList> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // Usando o title recebido como parâmetro
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: buscarExercicios(
            widget.search), // Realiza a busca com o termo 'quadríceps'
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Exibe um indicador de carregamento enquanto os dados estão sendo buscados
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Exibe uma mensagem de erro se ocorrer algum erro
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Exibe uma mensagem se não houver dados encontrados
            return const Center(child: Text('Nenhum exercício encontrado.'));
          } else {
            // Exibe a lista de exercícios encontrados
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // Constrói um card para cada exercício encontrado
                DocumentSnapshot exercicio = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(exercicio['name']),
                    subtitle: Text(exercicio['target']),
                    onTap: () {
                      // Ação ao clicar no exercício
                      print('Clicou no exercício ${exercicio['name']}');
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}