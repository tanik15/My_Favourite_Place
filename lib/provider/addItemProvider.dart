import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favourite_places/models/places.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';



Future<Database> getDAtaBase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY , title TEXT , image TEXT , address TEXT)');
  }, version: 1);
  return db;
}

class AddItemNotifier extends StateNotifier<List<Places>> {
  AddItemNotifier() : super([]);

  Future<void> loadData() async {
    final db = await getDAtaBase();
    final data = await db.query('user_places');
    final places = data
        .map(
          (e) => Places(
              id: e['id'] as String,
              title: e['title'] as String,
              image: File(e['image'] as String),
              address: e['address'] as String),
        )
        .toList();
    state = places;
  }

  void addItem(String title, File img, String add) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(img.path);
    final copiedImg = await img.copy('${appDir.path}/$filename');
    final name = Places(title: title, image: copiedImg, address: add);

    final db = await getDAtaBase();
    db.insert('user_places', {
      'id': name.id,
      'title': name.title,
      'image': name.image.path,
      'address': name.address
    });

    print(title);
    // print("CONGRATULATIONS YOU SAVED THE DATA $state");
    state = [name, ...state];
  }
}

final addItemProvider = StateNotifierProvider<AddItemNotifier, List<Places>>(
    (ref) => AddItemNotifier());
