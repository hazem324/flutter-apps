import 'package:b2b_app/models/product_model.dart';

class CommandLine {
  String id;
  int quantityDemanded;
  int confirmedQuantity;
  double prixHt;
  double prixTtc;
  int tva;
  DateTime createdAt;
  DateTime updatedAt;
  ProductModel product;
  String productId;

  CommandLine({
    required this.id,
    required this.quantityDemanded,
    required this.confirmedQuantity,
    required this.prixHt,
    required this.prixTtc,
    required this.tva,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.productId,
  });

  factory CommandLine.fromJson(Map<String, dynamic> json) {
    return CommandLine(
      id: json['id'],
      quantityDemanded: json['quantity_demanded'],
      confirmedQuantity: json['confirmed_quantity'],
      prixHt: json['prix_ht'].toDouble(),
      prixTtc: json['prix_ttc'].toDouble(),
      tva: json['tva'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      product: ProductModel.fromJson(json['product']),
      productId: json['productId'],
    );
  }
}