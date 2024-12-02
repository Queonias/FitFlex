import 'package:flutter/material.dart';
import 'package:academia/widgets/card_dia.dart';

class Tips extends StatefulWidget {
  const Tips({super.key});

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dicas'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Aqui você encontrará dicas para melhorar seu treino.'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Exibir o primeiro diálogo
          _showFirstDialog(context);
        },
        child: const Icon(Icons.add), // Ícone de '+'
      ),
    );
  }

  // Função para exibir o primeiro diálogo com lista de dias
  void _showFirstDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Dias da Semana'),
          content: SizedBox(
            width: double.maxFinite,
            height: 200, // Define a altura do diálogo
            child: ListView(
              children: const [
                CardDia(),
                ListTile(
                  title: Text('Segunda-feira'),
                ),
                ListTile(
                  title: Text('Terça-feira'),
                ),
                ListTile(
                  title: Text('Quarta-feira'),
                ),
                ListTile(
                  title: Text('Quinta-feira'),
                ),
                ListTile(
                  title: Text('Sexta-feira'),
                ),
                ListTile(
                  title: Text('Sábado'),
                ),
                ListTile(
                  title: Text('Domingo'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
