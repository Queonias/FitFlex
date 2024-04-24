import 'package:academia/helpers/conect_db.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:typed_data';

class CardList extends StatelessWidget {
  final DocumentSnapshot exercicio;

  CardList({
    Key? key,
    required this.exercicio,
  }) : super(key: key);

  final storage = FirebaseStorage.instance;
  final cacheManager = DefaultCacheManager();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Row(
            children: [
              FutureBuilder<Uint8List?>(
                future: ConectDB().searchImage(exercicio['gifUrl']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Se ainda estiver carregando, exibe um indicador de progresso
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Se houver um erro, exibe um ícone de erro
                    return const Icon(Icons.error);
                  } else if (snapshot.hasData && snapshot.data != null) {
                    // Se houver dados no snapshot e não estiver vazio, exibe a imagem
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.circular(0), // Borda personalizada
                      child: Image.memory(
                        snapshot.data!,
                        height: 100, // Altura da imagem
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    // Se não houver dados no snapshot ou se os dados estiverem vazios, exibe uma mensagem de erro ou placeholder
                    return const Text('Imagem não encontrada');
                  }
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          exercicio['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        'Objetivo: ${exercicio['target']}',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
