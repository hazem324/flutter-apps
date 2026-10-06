class RegionModel {
  final String name;
  final String delegation;
  RegionModel({ required this.name, required this.delegation});

  factory RegionModel.fromJson(Map<String, dynamic> map) {
    return RegionModel(
      name: map["Name"],
      delegation: map["Delegations"]
    );
  }
}
