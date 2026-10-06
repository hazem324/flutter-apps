import 'command_line_model.dart';

class OrderModel {
  String id;
  String numero;
  double prixTotalHt;
  double prixTotalTtc;
  double prixTotalRemiseTtc;
  double prixTotalRemiseHt;
  String status;
  double deliveryCharges;
  DateTime createdAt;
  DateTime updatedAt;
  List<CommandLine> commandLines;

  OrderModel({
    required this.id,
    required this.numero,
    required this.prixTotalHt,
    required this.prixTotalTtc,
    required this.prixTotalRemiseTtc,
    required this.prixTotalRemiseHt,
    required this.status,
    required this.deliveryCharges,
    required this.createdAt,
    required this.updatedAt,
    required this.commandLines,
   
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
  return OrderModel(
    id: json['id'] ?? '',
    numero: json['numero'] ?? '',
    prixTotalHt: (json['prix_total_ht'] as num?)?.toDouble() ?? 0.0,
    prixTotalTtc: (json['prix_total_ttc'] as num?)?.toDouble() ?? 0.0,
    prixTotalRemiseTtc: (json['prix_total_remise_ttc'] as num?)?.toDouble() ?? 0.0,
    prixTotalRemiseHt: (json['prix_total_remise_ht'] as num?)?.toDouble() ?? 0.0,
    status: json['status'] ?? '',
    deliveryCharges: (json['delivery_charges'] as num?)?.toDouble() ?? 0.0,
    createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
    commandLines: json['command_lines'] != null
        ? List<CommandLine>.from(
            json['command_lines'].map((x) => CommandLine.fromJson(x)),
          )
        : [],
  );
}

}