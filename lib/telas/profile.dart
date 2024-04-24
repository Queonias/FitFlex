import 'dart:typed_data';

import 'package:academia/helpers/conect_db.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ConectDB _db = ConectDB(); // Instância da classe ConectDB

  final String _profileData = 'Popular banco de dados';

  Uint8List? _imageBytes; // Bytes da imagem recuperada do banco de dados

  _populateProfileData() async {
    print('Populando banco de dados...');
    try {
      await _db.saveImageToDatabase('ok67IcM1M--sWG');
      print('Banco de dados populado com sucesso!');
    } catch (e) {
      print('Erro ao popular banco de dados: $e');
    }
  }

  _carregarImagem() async {
    try {
      // Recupera a imagem do banco de dados pelo nome
      _imageBytes = await _db.getImageByName('ok67IcM1M--sWG');
      setState(() {}); // Atualiza o estado para refletir a nova imagem
    } catch (e) {
      print('Erro ao carregar imagem: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: _carregarImagem,
            child: const Text('Carregar imagem'),
          ),
          const Text('Profissional'),
          TextButton(
            onPressed: _populateProfileData,
            child: Text(_profileData),
          ),
          if (_imageBytes != null)
            Image.memory(
              _imageBytes!, // Exibe a imagem a partir dos bytes recuperados
              width: 200, // Defina a largura da imagem conforme necessário
              height: 200, // Defina a altura da imagem conforme necessário
            ),
        ],
      ),
    );
  }
}
