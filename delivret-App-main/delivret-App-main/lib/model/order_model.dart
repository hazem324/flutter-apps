import 'address_model.dart';

class OrderModel {
  String? id;
  String? nom;
  int? prix;
  AddressModel? departureAddress;
  AddressModel? deliveryAddress;
  User client;
  User? livreur;
  int status;
  String? description;

  OrderModel(
      {this.id,
      this.nom,
      this.prix,
      this.departureAddress,
      this.deliveryAddress,
      required this.status,
      this.description,
     required this.client,
      this.livreur});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['_id'],
       nom: json['nom'],
        prix: json['prix'],
      departureAddress: AddressModel.fromJson(
          json['departureAddress'] as Map<String, dynamic>),
      deliveryAddress: AddressModel.fromJson(json['deliveryAddress'] as Map<String, dynamic>),
      status: json['status'],
      description: json['description'],
      client: User.fromJson(json['client'] as Map<String, dynamic>),
      livreur: json['livreur'] != null
          ? User.fromJson(json['livreur'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['departureAddress'] = this.departureAddress?.toJson();
    data['deliveryAddress'] = this.deliveryAddress?.toJson();
    data['client'] = this.client.id;
    data['status'] = this.status;
    data['description'] = this.description;
    data['nom'] = this.nom;
    data['prix'] = this.prix;

    return data;
  }
}

class User {
  final String? id;
  final String? nom;
  final String? prenom;
  final int? phoneNum;
  final String? imgUrl;

  User({this.id, this.nom, this.prenom, this.phoneNum, this.imgUrl});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        id: map["_id"] ?? null,
        nom: map['nom'],
        prenom: map['prenom'],
        phoneNum: map['numeroDeTelephone'],
        imgUrl: map['image']);
  }
}
