import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CardList extends StatelessWidget {
  final DocumentSnapshot exercicio;

  CardList({
    Key? key,
    required this.exercicio,
  }) : super(key: key);

  final storage = FirebaseStorage.instance;

  Future<String> loadImage(String imagePath) async {
    try {
      String path = 'imagens/$imagePath';
      // Referência para o arquivo de imagem no Firebase Storage
      final storageRef = FirebaseStorage.instance.ref();
      // Create a reference with an initial file path and name
      final pathReference = storageRef.child(path);

      // Obtém a URL de download da imagem
      final String downloadUrl = await pathReference.getDownloadURL();

      return downloadUrl;
    } catch (error) {
      print('Erro ao carregar imagem: $error');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Row(
            children: [
              FutureBuilder<String>(
                future: loadImage(exercicio['gifUrl']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error);
                  } else {
                    return ClipRRect(
                      borderRadius:
                          BorderRadius.circular(0), // Borda personalizada
                      child: Image.network(
                        snapshot.data!,
                        height: 100, // Altura da imagem
                        fit: BoxFit.cover,
                      ),
                    );
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




 // return GridView.builder(
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     crossAxisSpacing: 8.0,
    //     mainAxisSpacing: 8.0,
    //     mainAxisExtent: 300,
    //   ),
    //   itemCount: quantidadeExercicios,
    //   itemBuilder: (context, index) {
    //     return const Card(
    //       elevation: 4,
    //       // shape: RoundedRectangleBorder(
    //       //   borderRadius: BorderRadius.circular(0),
    //       // ),
    //       child: Column(
    //         children: [
    //           // FutureBuilder<String>(
    //           //   future: loadImage(exercicio['gifUrl']),
    //           //   builder: (context, snapshot) {
    //           //     if (snapshot.connectionState == ConnectionState.waiting) {
    //           //       return const CircularProgressIndicator();
    //           //     } else if (snapshot.hasError) {
    //           //       return const Icon(Icons.error);
    //           //     } else {
    //           //       return ClipRRect(
    //           //         borderRadius:
    //           //             BorderRadius.circular(0), // Borda personalizada
    //           //         child: Image.network(
    //           //           snapshot.data!,
    //           //           width: double.infinity,
    //           //           height: 200,
    //           //           fit: BoxFit.cover,
    //           //         ),
    //           //       );
    //           //     }
    //           //   },
    //           // ),
    //         ],
    //       ),
    //     );
    //   },
    // );
    // return Card(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(0),
    //   ),
    //   child: Column(
    //     children: [
    //       FutureBuilder<String>(
    //         future: loadImage(exercicio['gifUrl']),
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return const CircularProgressIndicator();
    //           } else if (snapshot.hasError) {
    //             return const Icon(Icons.error);
    //           } else {
    //             return ClipRRect(
    //               borderRadius: BorderRadius.circular(0), // Borda personalizada
    //               child: Image.network(
    //                 snapshot.data!,
    //                 width: double.infinity,
    //                 height: 200,
    //                 fit: BoxFit.cover,
    //               ),
    //             );
    //           }
    //         },
    //       ),
    //       ListTile(
    //         dense: false,
    //         contentPadding: const EdgeInsets.all(0),
    //         title: Text(
    //           exercicio['name'],
    //           style: const TextStyle(
    //             color: Color.fromARGB(255, 0, 0, 0),
    //             fontWeight: FontWeight.bold,
    //             fontSize: 20,
    //             overflow: TextOverflow.ellipsis,
    //           ),
    //         ),
    //         subtitle: Text(
    //           exercicio['target'],
    //           style: const TextStyle(
    //             color: Color.fromARGB(255, 0, 0, 0),
    //             fontSize: 16,
    //             overflow: TextOverflow.ellipsis,
    //           ),
    //         ),
    //         onTap: () {
    //           // Navigator.push(
    //           //     context,
    //           //     MaterialPageRoute(
    //           //       builder: (context) =>
    //           //           ExercicioList(title: title, search: search),
    //           //     ));
    //         },
    //       ),
    //     ],
    //   ),
    // );