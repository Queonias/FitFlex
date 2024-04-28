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
        children: const [
          CustomCard(
            title: 'Treino de costas',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_de_costa.jpg',
            search: 'costas',
          ),
          CustomCard(
            title: 'Treino cardio',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_cardio.jpg',
            search: 'cardio',
          ),
          CustomCard(
            title: 'Treino de peito',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_peito.jpg',
            search: 'peito',
          ),
          CustomCard(
            title: 'Treino de braços inferiores',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_bracos_inferiores.jpg',
            search: 'braços inferiores',
          ),
          CustomCard(
            title: 'Treino de pernas inferiores',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_pernas_inferiores.jpg',
            search: 'pernas inferiores',
          ),
          CustomCard(
            title: 'Treino de pescoço',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_pescoco.jpg',
            search: 'pescoço',
          ),
          CustomCard(
            title: 'Treino de ombros',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_ombros.jpg',
            search: 'ombros',
          ),
          CustomCard(
            title: 'Treino de pernas superiores',
            duration: '2 horas e 20 minutos',
            level: 'Iniciante',
            image: 'assets/imagens/treino_de_costa.jpg',
            search: 'pernas superiores',
          ),
          CustomCard(
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
