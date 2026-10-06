class ClientModel {

  final String username;
  final String fullName;
  final String address;
  final String city;
  final String governorate;
  final String phoneNumber;
  final String role;

  ClientModel({
     
    required this.username,
    required this.fullName,
    required this.address,
    required this.city,
    required this.governorate,
    required this.phoneNumber,
    required this.role,
  }
  );

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      
      username: json['username'],
      fullName: json['fullName'],
      address: json['address'],
      city: json['city'],
      governorate: json['governorate'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
       
        'username': username,
        'fullName': fullName,
        'address': address,
        'city': city,
        'governorate': governorate,
        'phoneNumber': phoneNumber,
        'role': role,
      };
}
