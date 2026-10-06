import 'remise_model.dart';

class SupplierProductModel {
  final String id;
  final String name;
  final String? email;
  final String? phoneNumber;
  final String address;
  final String? governorate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<RemiseModel> remises;

  SupplierProductModel({
    required this.id,
    required this.name,
    this.email,
    this.phoneNumber,
    required this.address,
    this.governorate,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.remises,
  });

  factory SupplierProductModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SupplierProductModel(
        id: '',
        name: '',
        email: null,
        phoneNumber: null,
        address: '',
        governorate: null,
        isActive: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        remises: [],
      );
    }

    return SupplierProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'] ?? '',
      governorate: json['governorate'],
      isActive: json['isActive'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      remises: (json['remises'] as List<dynamic>?)
              ?.map((e) => RemiseModel.fromJson(e))
              .toList() ??
          [],
    );
  }



Map<String, dynamic> toJsonForLocalStorage() {
  return {
    'id': id,
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'address': address,
    'governorate': governorate,
    'isActive': isActive,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'remises': remises.map((r) => r.toJson()).toList(),
  };
}
  
}
