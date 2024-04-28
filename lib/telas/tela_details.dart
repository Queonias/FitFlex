import 'package:academia/helpers/conect_db.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';

class TelaDetails extends StatefulWidget {
  final DocumentSnapshot exercicio;
  final String title;
  const TelaDetails({Key? key, required this.exercicio, required this.title})
      : super(key: key);

  @override
  State<TelaDetails> createState() => _TelaDetailsState();
}

class _TelaDetailsState extends State<TelaDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercicio['bodyPart'],
            style: const TextStyle(overflow: TextOverflow.ellipsis)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<Uint8List?>(
                future: ConectDB()
                    .searchImage(widget.exercicio['gifUrl'], 'imagens'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error);
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.circular(0), // Borda personalizada
                      child: Image.memory(
                        snapshot.data!,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    return const Text('Imagem não encontrada');
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Musculos Secundários',
                        style: TextStyle(fontSize: 16)),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemExtent: 25,
                    itemCount: widget.exercicio['secondaryMuscles'].length,
                    itemBuilder: (context, index) {
                      final muscle =
                          widget.exercicio['secondaryMuscles'][index];
                      return ListTile(
                        leading: const Icon(Icons.arrow_right,
                            size: 24, color: Color.fromARGB(255, 11, 52, 187)),
                        title: Text(muscle),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 30, bottom: 20, left: 8),
                          child: Text(
                            'Instruções',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.exercicio['instructions'].length,
                          itemBuilder: (context, index) {
                            final instruction =
                                widget.exercicio['instructions'][index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.fiber_manual_record,
                                    size: 16,
                                    color: Color.fromARGB(255, 11, 52, 187),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      instruction,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
