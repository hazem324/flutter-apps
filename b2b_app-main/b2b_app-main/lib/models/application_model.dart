import 'makes_model.dart'; 

class ApplicationModel {
  final String id;
  final MakesModel make;
  final MakesModel model;
  final MakesModel version;

  ApplicationModel({
    required this.id,
    required this.make,
    required this.model,
    required this.version,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
    id: json['id'] ?? '',
    make: json['make'] != null
        ? MakesModel.fromJson(json['make'] as Map<String, dynamic>)
        : MakesModel(id: '', name: ''),
    model: json['model'] != null
        ? MakesModel.fromJson(json['model'] as Map<String, dynamic>)
        : MakesModel(id: '', name: ''),
    version: json['version'] != null
        ? MakesModel.fromJson(json['version'] as Map<String, dynamic>)
        : MakesModel(id: '', name: ''),
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'make': make.toJson(),
      'model': model.toJson(),
      'version': version.toJson(),
    };
  }
}
