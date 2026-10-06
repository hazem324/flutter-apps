class OemMakeModel {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDefault;
  final String oem;
  final String productId;

  OemMakeModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.isDefault,
    required this.oem,
    required this.productId,
  });

  factory OemMakeModel.fromJson(Map<String, dynamic> json) {
     return OemMakeModel(
    id: json['id'] ?? '',
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : DateTime.now(),
    updatedAt: json['updatedAt'] != null
        ? DateTime.parse(json['updatedAt'])
        : DateTime.now(),
    isDefault: json['default'] ?? false,
    oem: json['oem'] ?? '',
    productId: json['productId'] ?? '',
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'default': isDefault,
      'oem': oem,
      'productId': productId,
    };
  }
}
