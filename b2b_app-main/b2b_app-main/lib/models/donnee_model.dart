class DonneeModel {
  final String ref;
  // final String desig;
  // final String magasin;
  // final double pv;
final num stock;
  DonneeModel({
    required this.ref,
    // required this.desig,
    // required this.magasin,
    // required this.pv,
    required this.stock,
  });

  factory DonneeModel.fromJson(Map<String, dynamic> json) {
    return DonneeModel(
      ref: json['ref'],
    //  desig: json['desig'],
   //   magasin: json['magasin'],
  //   pv: json['pv'],//  (json['pv'] is int ? (json['pv'] as int).toDouble() : json['pv'] as double),
      stock: json['stock'],
    );
  }
}
