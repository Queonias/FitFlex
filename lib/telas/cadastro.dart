import 'dart:typed_data';

import 'package:academia/telas/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:academia/home.dart';
import 'package:academia/model/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:academia/helpers/conect_db.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController _controllerNome =
      TextEditingController(text: "Queonias");
  final TextEditingController _controllerEmail =
      TextEditingController(text: "queonias@gmail.com");
  final TextEditingController _controllerSenha =
      TextEditingController(text: "123456");

  void _validarCampos() {
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (nome.isNotEmpty && nome.length >= 3) {
      if (email.isNotEmpty && email.contains("@")) {
        if (senha.isNotEmpty && senha.length > 6) {
          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;
          _cadastrarUsuario(usuario);
        } else {
          setState(() {
            const snackBar = SnackBar(
              content: Text("Preencha a senha!"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
      } else {
        setState(() {
          const snackBar = SnackBar(
            content: Text("Preencha o e-mail utilizando @"),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      }
    } else {
      setState(() {
        const snackBar = SnackBar(
          content: Text("Nome precisa ter mais que 2 caracteres!",
              style: TextStyle(color: Colors.red)),
          // backgroundColor: Colors.red,

          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {
      FirebaseFirestore db = FirebaseFirestore.instance;
      db
          .collection("usuarios")
          .doc(firebaseUser.user!.uid)
          .set(usuario.toMap());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Menu()),
        (route) => false, // Remove todas as rotas na pilha
      );
    }).catchError((error) {
      setState(() {
        const snackBar = SnackBar(
          content: Text(
              "Erro ao cadastrar usuário, verifique os campos e tente novamente!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 58, 148, 183),
            title:
                const Text('Cadastro', style: TextStyle(color: Colors.white)),
            iconTheme: const IconThemeData(color: Colors.white)),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/imagens/fundo.jpg"),
                  fit: BoxFit.cover)),
          child: FutureBuilder<Uint8List?>(
            future: ConectDB().searchImage('profile.png', 'imagem_perfil'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Icon(Icons.error));
              } else if (snapshot.hasData && snapshot.data != null) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 32),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(500),
                                  child: Image.memory(
                                    snapshot.data!,
                                    fit: BoxFit.fill,
                                    height: 180,
                                    width: 180,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: TextField(
                              controller: _controllerNome,
                              autofocus: true,
                              keyboardType: TextInputType.text,
                              style: const TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(32, 16, 32, 16),
                                hintText: "Nome",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: TextField(
                              controller: _controllerEmail,
                              autofocus: false,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(32, 16, 32, 16),
                                hintText: "E-mail",
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32)),
                              ),
                            ),
                          ),
                          TextField(
                            controller: _controllerSenha,
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            style: const TextStyle(fontSize: 20),
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(32, 16, 32, 16),
                              hintText: "Senha",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32)),
                            ),
                            obscureText: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                _validarCampos();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 58, 148, 183),
                                padding:
                                    const EdgeInsets.fromLTRB(32, 16, 32, 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                              child: const Text(
                                "Cadastrar",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const Text('Sem conexão com a internet');
              }
            },
          ),
          // child:
        ));
  }
}
