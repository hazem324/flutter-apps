import 'dart:convert';

import 'package:b2b_app/models/cart_item_model.dart';
import 'package:b2b_app/models/command_model.dart';
import 'package:get/get.dart';

import '../utils/conf_sqf_lite.dart';

class CartController extends GetxController {
  var cartItems = <CartItemModel>[].obs;
  RxDouble totalHt = 0.0.obs;
  RxDouble totalTtc = 0.0.obs;
  RxDouble deliveryFee = 9.0.obs;
  Rx itemsCoun = 0.obs;


void increment() {
 itemsCoun.value = itemsCoun.value + 1;
 print("item counts is ${itemsCoun.value}");
} 
  void decrement() {
    if (itemsCoun.value > 0) {
 itemsCoun.value = itemsCoun.value - 1;
 print("item counts is ${itemsCoun.value}");
    }
  }




  // Ajouter un produit au panier
  Future<int> addItem(CartItemModel cartItemModel) async {
    int result = await ConfCartDB.insertItem(cartItemModel);
     itemsCoun.value = itemsCoun.value + 1;
     await getCart();
    return result;
  }

  Future<void> getCart() async {
  List<Map<String, dynamic>> tasks = await ConfCartDB.query();
  cartItems.assignAll(tasks.map((data) => CartItemModel.fromJson(data)).toList());
  itemsCoun.value = cartItems.length;

  final cartJsonList = cartItems.map((item) => item.toJson()).toList();
  final cartJsonString = jsonEncode(cartJsonList);
  print("Cart Items in JSON:\n$cartJsonString");
}

  Future<int> removeItemByProductId(String productId) async {
    int result = await ConfCartDB.deleteItemByProductId(productId);
    itemsCoun.value = itemsCoun.value - 1;
     await getCart(); 
  //  decrement();
    return result;
  }

  // Mettre à jour la quantité d’un article
  Future<int> updateItemQuantity(String productId, int newQuantity) async {
   
    final existingItem = cartItems.firstWhereOrNull((item) => item.product.id == productId);
    if (existingItem == null) return -1;

    final updatedItem = CartItemModel(
      product: existingItem.product,
      quantity: newQuantity,
    );
    int result = await ConfCartDB.updateItem(updatedItem);
    await getCart();
    return result;
  }

  Future<void> clearCart() async {
    await ConfCartDB.clearCart();
    cartItems.clear();
    itemsCoun.value = 0;
  }


Future<void> calculTotal() async {
    double ht = 0.0;
    double ttc = 0.0;

    for (var item in cartItems) {
      final quantity = item.quantity;
      final prixHT = item.product.prixHt;
      final tva = item.product.tva;

      // Appliquer la remise fournisseur s’il y en a une
      double remise = 0.0;
      if (item.product.supplier != null &&
          item.product.supplier!.remises.isNotEmpty &&
          item.product.supplier!.remises.first.isActive == true) {
        remise = item.product.supplier!.remises.first.remisePercentage;
      }

      double prixRemiseHT = prixHT * (1 - remise / 100);
      double totalItemHT = prixRemiseHT * quantity;

      double prixRemiseTTC = prixRemiseHT * (1 + tva / 100);
      double totalItemTTC = prixRemiseTTC * quantity;

      ht += totalItemHT;
      ttc += totalItemTTC;
    }

    totalHt.value = ht;
    totalTtc.value = ttc;

    print("Total HT: ${totalHt.value.toStringAsFixed(2)}");
    print("Total TTC: ${totalTtc.value.toStringAsFixed(2)}");
    print("Delivery Fee: ${deliveryFee.value.toStringAsFixed(2)}");
  }

CommandModel toCommandModel() {
  List<CommandLine> lines = cartItems.map((item) {
    return CommandLine(
      product: item.product.id,
      quantityDemanded: item.quantity,
    );
  }).toList();

  return CommandModel(
    prixTotalHt: totalHt.value,
    prixTotalTtc: totalTtc.value,
    prixTotalRemiseTtc: 0, 
    prixTotalRemiseHt: 0, 
    deliveryCharges: deliveryFee.value,
    commandLines: lines,
  );
}
}
