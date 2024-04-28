import 'package:academia/widgets/card_home.dart';
import 'package:flutter/material.dart';

class AbaIniciante extends StatefulWidget {
  const AbaIniciante({super.key});

  @override
  State<AbaIniciante> createState() => _AbaInicianteState();
}

class _AbaInicianteState extends State<AbaIniciante> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Iniciante',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ),
          const CustomCard(
            title: 'Treino de costas',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_de_costa.jpg',
            search: 'costas',
          ),
          const CustomCard(
            title: 'Treino cardio',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_cardio.jpg',
            search: 'cardio',
          ),
          const CustomCard(
            title: 'Treino de peito',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_peito.jpg',
            search: 'peito',
          ),
          const CustomCard(
            title: 'Treino de braços',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_bracos_inferiores.jpg',
            search: 'braços',
          ),
          const CustomCard(
            title: 'Treino de pernas inferiores',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_pernas_inferiores.jpg',
            search: 'pernas inferiores',
          ),
          const CustomCard(
            title: 'Treino de pescoço',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_pescoco.jpg',
            search: 'pescoço',
          ),
          const CustomCard(
            title: 'Treino de ombros',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_ombros.jpg',
            search: 'ombros',
          ),
          const CustomCard(
            title: 'Treino de pernas superiores',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_de_costa.jpg',
            search: 'pernas superiores',
          ),
          const CustomCard(
            title: 'Treino de cintura',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_de_costa.jpg',
            search: 'cintura',
          ),
        ],
      ),
    );
  }
}
