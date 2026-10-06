class SupplierModel {
  final String id;
  final String name;

  const SupplierModel({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }

  factory SupplierModel.fromJson(Map<String, dynamic> map) {
    return SupplierModel(id: map["id"], name: map["name"]);
  }
}
