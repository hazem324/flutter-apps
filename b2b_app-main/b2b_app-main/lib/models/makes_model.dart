class MakesModel {
  final String id;
  final String name;
 

  MakesModel({required this.id, required this.name});

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    
  };

  factory MakesModel.fromJson(Map<String, dynamic> map) {
    return MakesModel(
      id: map["id"],
      name: map["name"],
    );
  }
}