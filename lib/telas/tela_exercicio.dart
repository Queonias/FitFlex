import 'package:academia/helpers/conect_farebase.dart';
import 'package:academia/telas/tela_details.dart';
import 'package:academia/widgets/card_list_exercici.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // Usando o title recebido como parâmetro
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: FarebaseDB().buscarExercicios(
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
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, right: 5.0, left: 5.0),
                  child: GestureDetector(
                    onTap: () {
                      // Ação desejada quando o usuário clicar no card
                      print('Card clicado: ${exercicio['name']}');
                      // Adicione aqui a ação que deseja executar
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaDetails(
                                exercicio: exercicio, title: widget.title),
                          ));
                    },
                    child: CardList(
                      exercicio: exercicio,
                    ),
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
