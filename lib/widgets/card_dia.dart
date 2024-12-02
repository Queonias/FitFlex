import 'package:flutter/material.dart';

class CardDia extends StatefulWidget {
  const CardDia({super.key});

  @override
  State<CardDia> createState() => _CardDiaState();
}

class _CardDiaState extends State<CardDia> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          // Image.asset('assets/imagens/treino_costas.jpg'),
          ListTile(
            title: Text('Treino de costas'),
            subtitle: Text('2 horas e 20 minutos'),
          ),
        ],
      ),
    );
  }
}
