import 'package:sqflite/sqflite.dart';

import '../models/cart_item_model.dart' show CartItemModel;

class ConfCartDB {
  static Database? _bd;
  static final int version = 1;
  static final String tableName = "cartTable";

  static Future<void> initialDB() async {
    if (_bd != null) {
      return;
    }
    try {
      String path = "${await getDatabasesPath()}/cart.db";
      print("Database path is: $path/cart.db");
      _bd = await openDatabase(
        path,
        version: version,
        onCreate: (db, version) {
          print("create a db =================");
          db.execute('''
CREATE TABLE "$tableName" (
id INTEGER PRIMARY KEY AUTOINCREMENT,
quantity INTEGER NOT NULL,
  product TEXT NOT NULL
)''');
        },
      );
    } catch (e) {
      print("data base initial problem $e");
    }
  }


  static Future<List<Map<String, dynamic>>> query() async {
     await initialDB();

    print("the query method has called            =");
    return _bd!.query(tableName);
  }


 static Future<int> insertItem(CartItemModel? cartItemModel) async {
  await ConfCartDB.initialDB();

  if (_bd == null || cartItemModel == null) {
    print("Insert failed: DB or cartItemModel is null");
    return -1;
  }

  // Vérifie si un produit avec le même ID existe déjà
  List<Map<String, dynamic>> items = await _bd!.query(tableName);

  for (var item in items) {
    final existing = CartItemModel.fromJson(item);
    if (existing.product.id == cartItemModel.product.id) {
      print("Product already exists in cart. Skipping insert.");
      return -1;
    }
  }

  print("INSERT METHOD HAS CALLED");
  return await _bd!.insert(tableName, cartItemModel.toJson());
}

  static Future<int> deleteItem(int id) async {
    if (_bd == null) {
      print("Delete failed: DB is null");
      return -1;
    }
    return await _bd!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }


static Future<int> deleteItemByProductId(String productId) async {
  await initialDB();

  List<Map<String, dynamic>> items = await _bd!.query(tableName);

  for (var item in items) {
    final existing = CartItemModel.fromJson(item);
    if (existing.product.id == productId) {
      return await _bd!.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [item['id']],
      );
    }
  }

  return -1;
}


static Future<int> updateItem(CartItemModel updatedItem) async {
  await initialDB();

  List<Map<String, dynamic>> items = await _bd!.query(tableName);

  for (var item in items) {
    final existing = CartItemModel.fromJson(item);
    if (existing.product.id == updatedItem.product.id) {
      return await _bd!.update(
        tableName,
        updatedItem.toJson(),
        where: 'id = ?',
        whereArgs: [item['id']],
      );
    }
  }

  return -1;
}


static Future<void> clearCart() async {
  await initialDB();
  await _bd!.delete(tableName);
}

}

