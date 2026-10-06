class OrderInfo {
  final String id;
  final double latitude;
  final double longitude;
  //final String colisName;
  final String clientName;
  final String clientPhone;
  final String status;

  OrderInfo({
    required this.id,
    required this.latitude,
    required this.longitude,
    //required this.colisName,
    required this.clientName,
    required this.clientPhone,
    required this.status,
  });
}
