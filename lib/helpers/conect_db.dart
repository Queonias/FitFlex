import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class ConectDB {
  ConectDB._internal();
  static final ConectDB _instance = ConectDB._internal();
  factory ConectDB() => _instance;

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  _initDB() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, 'db.db');
    try {
      var db = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
      return db;
    } catch (e) {
      print("error $e");
    }
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
       CREATE TABLE images(id INTEGER PRIMARY KEY, image BLOB, name TEXT)
      ''');
  }

  Future<void> saveImageToDatabase(String imageName) async {
    try {
      // Carrega a imagem do Firebase Storage
      String imageUrl = await loadImage(imageName);
      if (imageUrl.isEmpty) {
        print('URL de imagem vazia');
        return;
      }

      // Baixa a imagem a partir da URL
      http.Response response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        Uint8List bytes = response.bodyBytes;

        // Salva a imagem no banco de dados
        Database db = await this.db;
        await db.insert(
          'images',
          {'image': bytes, 'name': imageName},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        print('Imagem salva no banco de dados com sucesso!');
      } else {
        print('Falha ao baixar a imagem');
      }
    } catch (error) {
      print('Erro ao salvar imagem no banco de dados: $error');
    }
  }

  Future<Uint8List?> getImageByName(String name) async {
    Database db = await this.db;
    List<Map<String, dynamic>> result = await db.query(
      'images',
      columns: ['image'],
      where: 'name = ?',
      whereArgs: [name],
    );

    if (result.isNotEmpty) {
      return result.first['image'];
    } else {
      return null;
    }
  }

  Future<String> loadImage(String imagePath) async {
    try {
      // Caminho completo para o arquivo de imagem no Firebase Storage
      String path = 'imagens/$imagePath';

      // Referência para o arquivo de imagem no Firebase Storage
      final storageRef = FirebaseStorage.instance.ref(path);

      // Obtém a URL de download da imagem
      final String downloadUrl = await storageRef.getDownloadURL();

      // Retorna a URL de download da imagem
      return downloadUrl;
    } catch (error) {
      print('Erro ao carregar imagem: $error');
      return ''; // Retorna uma string vazia em caso de erro
    }
  }

  Future<Uint8List?> searchImage(name) async {
    Uint8List? image = await getImageByName(name);
    if (image == null) {
      await saveImageToDatabase(name);
      image = await getImageByName(name);
      return image;
    } else {
      return image;
    }
  }
}
