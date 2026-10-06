enum Status {
  processing,
  packaging,
  inTransit,
  delivered;

  static String orderStatus(int val) {
    switch (val) {
      case 0:
        return "Processing";
      case 1:
        return "packaging";
      case 2:
        return "In transit";
      case 3:
        return "Delivered";
    default:
      throw Exception('Invalid status value: $val');
    }
  }
}
extension StatusExtension on Status {
  int get intValue {
    switch (this) {
      case Status.processing:
        return 0;
      case Status.packaging:
        return 1;
      case Status.inTransit:
        return 2;
      case Status.delivered:
        return 3;
    }
  }
}