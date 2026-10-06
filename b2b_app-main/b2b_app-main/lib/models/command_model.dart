class CommandModel {
  final double prixTotalHt;
  final double prixTotalTtc;
  final double prixTotalRemiseTtc;
  final double prixTotalRemiseHt;
  final double deliveryCharges;
  final List<CommandLine> commandLines;

  CommandModel({
    required this.prixTotalHt,
    required this.prixTotalTtc,
    required this.prixTotalRemiseTtc,
    required this.prixTotalRemiseHt,
    required this.deliveryCharges,
    required this.commandLines,
  });

  factory CommandModel.fromJson(Map<String, dynamic> json) {
    return CommandModel(
      prixTotalHt: (json['prix_total_ht'] as num).toDouble(),
      prixTotalTtc: (json['prix_total_ttc'] as num).toDouble(),
      prixTotalRemiseTtc: (json['prix_total_remise_ttc'] as num).toDouble(),
      prixTotalRemiseHt: (json['prix_total_remise_ht'] as num).toDouble(),
      deliveryCharges: (json['delivery_charges'] as num).toDouble(),
      commandLines: (json['command_lines'] as List)
          .map((item) => CommandLine.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prix_total_ht': prixTotalHt,
      'prix_total_ttc': prixTotalTtc,
      'prix_total_remise_ttc': prixTotalRemiseTtc,
      'prix_total_remise_ht': prixTotalRemiseHt,
      'delivery_charges': deliveryCharges,
      'command_lines': commandLines.map((e) => e.toJson()).toList(),
    };
  }
}





class CommandLine {
  final String product;
  final int quantityDemanded;

  CommandLine({
    required this.product,
    required this.quantityDemanded,
  });

  factory CommandLine.fromJson(Map<String, dynamic> json) {
    return CommandLine(
      product: json['product'],
      quantityDemanded: json['quantity_demanded'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'quantity_demanded': quantityDemanded,
    };
  }
}

