import 'package:academia/telas/abas/abas_iniciante.dart';
import 'package:academia/telas/abas/abas_intermediario.dart';
import 'package:academia/telas/abas/abas_profissional.dart';
import 'package:academia/telas/abas/abas_todos.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          bottom: TabBar(
              indicatorWeight: 4,
              controller: _tabController,
              labelStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.visible,
                color: Colors.white,
              ),
              tabs: const [
                Tab(text: "Todos"),
                Tab(text: "Iniciante"),
                Tab(text: "Intermediário"),
                Tab(text: "Profissional"),
              ]),
        ),
        body: TabBarView(controller: _tabController, children: const [
          AbaTodos(),
          AbaIniciante(),
          AbaIntermediario(),
          AbaProfissional()
        ]));
  }
}
