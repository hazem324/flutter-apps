class RemiseModel {
  final String id;
  final double remisePercentage;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  RemiseModel({
    required this.id,
    required this.remisePercentage,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RemiseModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return RemiseModel(
        id: '',
        remisePercentage: 0,
        isActive: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }

    return RemiseModel(
      id: json['id'] ?? '',
      remisePercentage: (json['remisePercentage'] ?? 0).toDouble(),
      isActive: json['isActive'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'remisePercentage': remisePercentage,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
