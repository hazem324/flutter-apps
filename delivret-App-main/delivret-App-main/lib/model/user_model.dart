class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  int? phone;
  String? password;
  final String? imageUrl;
  final String? pinCode;
  UserModel(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.password,
      this.pinCode,
      this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map["_id"],
      firstName: map["nom"],
      lastName: map["prenom"],
      email: map["email"],
      phone: map["numeroDeTelephone"],
      password: map["password"],
      imageUrl: map['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "nom": firstName,
      "prenom": lastName,
      "email": email,
      "numeroDeTelephone": phone,
      "password": password,
      'otp': pinCode,
      'image': imageUrl,
    };
  }
}
