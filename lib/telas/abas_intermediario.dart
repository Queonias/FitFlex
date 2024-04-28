import 'package:academia/widgets/card_home.dart';
import 'package:flutter/material.dart';

class AbaIntermediario extends StatefulWidget {
  const AbaIntermediario({super.key});

  @override
  State<AbaIntermediario> createState() => _AbaIntermediarioState();
}

class _AbaIntermediarioState extends State<AbaIntermediario> {
  final String _nivel = 'Intermediário';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Intermediário',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          CustomCard(
            title: 'Treino de costas',
            duration: '2 horas e 20 minutos',
            level: _nivel,
            image: 'assets/imagens/treino_de_costa.jpg',
            search: 'costas',
          ),
          CustomCard(
            title: 'Treino cardio',
            duration: '2 horas e 20 minutos',
            level: _nivel,
            image: 'assets/imagens/treino_cardio.jpg',
            search: 'cardio',
          ),
          CustomCard(
            title: 'Treino de peito',
            duration: '2 horas e 20 minutos',
            level: _nivel,
            image: 'assets/imagens/treino_peito.jpg',
            search: 'peito',
          ),
          CustomCard(
            title: 'Treino de braços',
            duration: '2 horas e 20 minutos',
            level: _nivel,
            image: 'assets/imagens/treino_bracos_inferiores.jpg',
            search: 'braços',
          ),
          CustomCard(
            title: 'Treino de pernas inferiores',
            duration: '2 horas e 20 minutos',
            level: _nivel,
            image: 'assets/imagens/treino_pernas_inferiores.jpg',
            search: 'pernas inferiores',
          ),
          CustomCard(
            title: 'Treino de pescoço',
            duration: '2 horas e 20 minutos',
            level: _nivel,
            image: 'assets/imagens/treino_pescoco.jpg',
            search: 'pescoço',
          ),
          CustomCard(
            title: 'Treino de ombros',
            duration: '2 horas e 20 minutos',
            level: _nivel,
            image: 'assets/imagens/treino_ombros.jpg',
            search: 'ombros',
          ),
          CustomCard(
            title: 'Treino de pernas superiores',
            duration: '2 horas e 20 minutos',
            level: _nivel,
            image: 'assets/imagens/treino_de_costa.jpg',
            search: 'pernas superiores',
          ),
          CustomCard(
            title: 'Treino de cintura',
            duration: '2 horas e 20 minutos',
            level: _nivel,
            image: 'assets/imagens/treino_de_costa.jpg',
            search: 'cintura',
          ),
        ],
      ),
    );
  }
}
