import 'dart:convert';
import 'product_model.dart';

class CartItemModel {
  final int? id; // SQLite row ID
  final int quantity;
  final ProductModel product;

  CartItemModel({
    this.id,
    required this.quantity,
    required this.product,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'],
      quantity: map['quantity'],
      product: ProductModel.fromJson(jsonDecode(map['product'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'product': jsonEncode(product.toJsonForLocalStorage()), // Custom method for local save
    };
  }
}
