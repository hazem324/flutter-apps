import 'package:b2b_app/models/file_model.dart';

import 'application_model.dart' ;
import 'oam_make_model.dart';
import 'product_supplier_model.dart';

class ProductModel {
  final String id;
  final bool isActive;
  final double remise;
  final double prixHt;
  final int colisage;
  final double prixTtc;
  final String designation;
  final int tva;
  final String status;
  final String supplierId;
  final String categoryId;
  final int quantity;
  final List<ApplicationModel> applications;
  final List<OemMakeModel> oemMakes;
  final SupplierProductModel? supplier;
  final FileModel ? file;

  ProductModel({
    required this.id,
    required this.isActive,
    required this.remise,
    required this.prixHt,
    required this.colisage,
    required this.prixTtc,
    required this.designation,
    required this.tva,
    required this.status,
    required this.supplierId,
    required this.categoryId,
    required this.quantity,
    required this.applications,
    required this.oemMakes,
    required this.supplier,
    required this.file
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      isActive: json['isActive'] ?? false,
      remise: (json['remise'] as num?)?.toDouble() ?? 0.0,
      prixHt: (json['prix_ht'] as num?)?.toDouble() ?? 0.0,
      colisage: json['colisage'] ?? 0,
      prixTtc: (json['prix_ttc'] as num?)?.toDouble() ?? 0.0,
      designation: json['designation'] ?? '',
      tva: json['tva'] ?? 0,
      status: json['status'] ?? '',
      supplierId: json['supplier']?['id'] ?? '',
      categoryId: json['category']?['id'] ?? '',
      quantity: json['quantity'] ?? 0,
      applications: (json['applications'] as List?)
              ?.map((e) => ApplicationModel.fromJson(e))
              .toList() ?? [],
      oemMakes: (json['oemMakes'] as List?)
              ?.map((e) => OemMakeModel.fromJson(e))
              .toList() ?? [],
      supplier: json['supplier'] != null
          ? SupplierProductModel.fromJson(json['supplier'])
          : null,
      file: json['file'] !=null 
          ? FileModel.fromJson(json['file'])
          : null
    );
  }

 Map<String, dynamic> toJsonForLocalStorage() {
  return {
    'id': id,
    'isActive': isActive,
    'remise': remise,
    'prix_ht': prixHt,
    'colisage': colisage,
    'prix_ttc': prixTtc,
    'designation': designation,
    'tva': tva,
    'status': status,
    'supplierId': supplierId,
    'category': {'id': categoryId},
    'quantity': quantity,
    'file': file?.toJsonForLocalStorage(), 
    'supplier':supplier?.toJsonForLocalStorage(),
  };
}
}
