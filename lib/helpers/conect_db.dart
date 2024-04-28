import 'package:academia/helpers/conect_farebase.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

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
    CREATE TABLE imagens(
      id INTEGER PRIMARY KEY,
      image BLOB,
      name TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE imagem_perfil(
      id INTEGER PRIMARY KEY,
      image BLOB,
      name TEXT
    )
  ''');
  }

  Future<void> saveImageToDatabase(String imageName, String nameFolder) async {
    try {
      // Carrega a imagem do Firebase Storage
      String imageUrl = await FarebaseDB().loadImage(nameFolder, imageName);
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
          nameFolder,
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

  Future<Uint8List?> getImageByName(String name, String tableName) async {
    Database db = await this.db;
    List<Map<String, dynamic>> result = await db.query(
      tableName,
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

  Future<Uint8List?> searchImage(name, tableName) async {
    Uint8List? image = await getImageByName(name, tableName);
    if (image == null) {
      await saveImageToDatabase(name, tableName);
      image = await getImageByName(name, tableName);
      return image;
    } else {
      return image;
    }
  }
}
