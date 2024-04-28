import 'dart:typed_data';

import 'package:academia/helpers/conect_db.dart';
import 'package:academia/helpers/conect_farebase.dart';
import 'package:academia/telas/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final logger = Logger();
  late User? _user;
  late String _id = '';
  late String _nome = '';

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    setState(() {
      _id = _user!.uid;
    });
    FarebaseDB().getUser(_id).then((value) {
      if (value != null) {
        var jsonString = value.data() as Map<String, dynamic>;
        jsonString["nome"];
        setState(() {
          _nome = jsonString["nome"];
        });
      } else {
        logger.e('Documento não encontrado.');
      }
    });
  }

  logoff() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Erro ao fazer logout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Scaffold(
        body: FutureBuilder<Uint8List?>(
          future: ConectDB().searchImage('profile.png', 'imagem_perfil'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Icon(Icons.error));
            } else if (snapshot.hasData && snapshot.data != null) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  0), // Borda personalizada
                              child: Image.memory(
                                snapshot.data!,
                                fit: BoxFit.cover,
                                width: 100,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 1.0),
                              child: Text(_nome,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(_user!.email ?? '',
                                  style: const TextStyle(fontSize: 15)),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 20),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(Icons.person_rounded),
                                  ),
                                  Text('Perfil'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: ElevatedButton(
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(Icons.settings),
                                  ),
                                  Text('Configuração'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: ElevatedButton(
                        onPressed: () {
                          logoff();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                            (route) => false, // Remove todas as rotas na pilha
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.red[100],
                          foregroundColor: Colors.red[300],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(Icons.logout_rounded),
                                ),
                                Text('Sair'),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Text('Sem conexão com a internet');
            }
          },
        ),
      ),
    );
  }
}
