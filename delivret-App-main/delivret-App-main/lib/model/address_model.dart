class AddressModel {
  String? street;
  String? city;
  String? state;
  int? postalCode;
  AddressModel(
      {required this.street,
      required this.city,
      required this.state,
      required this.postalCode});

  factory AddressModel.fromJson(Map<String, dynamic> map) {
    return AddressModel(
      street: map["street"],
      city: map["city"],
      state: map["state"],
      postalCode: map["postalCode"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["street"] = street;
    data["city"] = city;
    data["state"] = state;
    data["postalCode"] = postalCode;
    return data;
  }
}