import 'package:academia/telas/exercicios.dart';
import 'package:academia/telas/profile.dart';
import 'package:academia/telas/timer.dart';
import 'package:flutter/material.dart';

class Tips extends StatefulWidget {
  const Tips({super.key});

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  final List<Widget> _telas = [
    const Exercicios(),
    const Profile(),
    const Timer(),
    const Tips()
  ];
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
        ));
  }
}
