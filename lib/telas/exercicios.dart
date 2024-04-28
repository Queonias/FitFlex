import 'package:academia/helpers/conect_farebase.dart';
import 'package:academia/telas/tela_details.dart';
import 'package:academia/widgets/card_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Exercicios extends StatefulWidget {
  const Exercicios({super.key});

  @override
  State<Exercicios> createState() => _ExerciciosState();
}

class _ExerciciosState extends State<Exercicios> {
  late ScrollController _scrollController;
  int quant = 10;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // O usuário chegou ao final da tela
      print("Usuário chegou ao final da tela!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Exercícios'),
        ),
        body: FutureBuilder<List<DocumentSnapshot>>(
          future: FarebaseDB().getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum exercício encontrado.'));
            } else {
              return GridView.builder(
                controller: _scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 10.0,
                    mainAxisExtent: 290,
                    childAspectRatio: 1.0),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  quant = snapshot.data!.length + 10;
                  DocumentSnapshot exercicio = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        print('Card clicado: ${exercicio['name']}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaDetails(
                              exercicio: exercicio,
                              title: exercicio['name'],
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        child: CardView(exercicio: exercicio),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
