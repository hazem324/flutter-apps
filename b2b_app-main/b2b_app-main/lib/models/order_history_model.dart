import 'order_model.dart';

class OrderHistoryModel {
  int total;
  bool hasNext;
  int nextPage;
  List<OrderModel> result;

  OrderHistoryModel({
    required this.total,
    required this.hasNext,
    required this.nextPage,
    required this.result,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      total: json['total'],
      hasNext: json['hasNext'],
      nextPage: json['nextPage'],
      result: List<OrderModel>.from(json['result'].map((x) => OrderModel.fromJson(x))),
    );
  }
}