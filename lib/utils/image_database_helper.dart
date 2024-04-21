import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ImageDatabase {
  static Database? _database;
  static final ImageDatabase instance = ImageDatabase._();

  ImageDatabase._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // Se o banco de dados não estiver inicializado, inicialize-o
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // Obtém o caminho do diretório onde será armazenado o banco de dados
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'images.db');

    // Abre o banco de dados
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Cria a tabela para armazenar as imagens
        await db.execute(
          'CREATE TABLE images (id INTEGER PRIMARY KEY, image BLOB)',
        );
      },
    );
  }

  Future<void> insertImage(File imageFile) async {
    // Converte a imagem para bytes
    final Uint8List bytes = await imageFile.readAsBytes();

    // Insere os bytes da imagem no banco de dados
    final db = await instance.database;
    await db.insert('images', {'image': bytes});
  }

  Future<File> getImage() async {
    final db = await instance.database;

    // Recupera os bytes da imagem do banco de dados
    final List<Map<String, dynamic>> maps = await db.query('images');
    final Uint8List bytes = maps.first['image'];

    // Obtem o diretório temporário
    final tempDir = await getTemporaryDirectory();
    final tempPath = join(tempDir.path, 'temp_image.png');
    final File tempImage = File(tempPath);

    // Escreve os bytes da imagem no arquivo temporário
    await tempImage.writeAsBytes(bytes);

    return tempImage;
  }
}
