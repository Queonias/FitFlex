import 'package:flutter/material.dart';

class AbaIntermediario extends StatefulWidget {
  const AbaIntermediario({super.key});

  @override
  State<AbaIntermediario> createState() => _AbaIntermediarioState();
}

class _AbaIntermediarioState extends State<AbaIntermediario> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Intermediário Page"),
    );
  }
}
