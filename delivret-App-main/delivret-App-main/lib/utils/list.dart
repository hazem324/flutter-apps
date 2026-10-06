import '../model/place_type_model.dart';

class MyData {
  static List<PlaceType> localType() {
    return [
       PlaceType(
        name: "Chez moi",
        imgPath: "user"),
         PlaceType(
        name: "Chez un particulier",
        imgPath: "home"),
        PlaceType(
        name: "En Magasin",
        imgPath: "shop"),
    ];
  }
}

