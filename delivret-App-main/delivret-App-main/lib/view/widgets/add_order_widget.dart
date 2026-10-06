// ignore_for_file: invalid_use_of_protected_member
import 'package:deliveryapp/controller/region_controller.dart';
import 'package:deliveryapp/model/order_model.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:deliveryapp/view/widgets/address_section_widget.dart';
import 'package:deliveryapp/view/widgets/elevation_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/orders_controller.dart';
import '../../model/address_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/list.dart';
import '../../utils/order_status_enum.dart';
import 'drop_down_widget.dart';
import 'place_type_container_widget.dart';
import 'text_field_widget.dart';
import 'text_title_widget.dart';

class AddOrderScrenn extends StatefulWidget {
  const AddOrderScrenn({super.key});

  @override
  AddOrderScrennState createState() => AddOrderScrennState();
}

class AddOrderScrennState extends State<AddOrderScrenn> {
  TextEditingController streetDepart = TextEditingController();
  TextEditingController codeDepart = TextEditingController();
  TextEditingController prix = TextEditingController();
  TextEditingController nom = TextEditingController();

  TextEditingController streetLivraison = TextEditingController();
  TextEditingController codeLivraison = TextEditingController();
  TextEditingController descreption = TextEditingController();
  OrderController orderController = Get.put(OrderController());
  RegionController regionController = Get.put(RegionController());

  String? cityDepart;
  String? stateDepart;
  String? cityLivraison;
  String? stateLivraison;
  bool isSelected = false;
  @override
  void initState() {
    super.initState();
    regionController.getRegionNames();
    // regionController.getDelegationsNames();
    streetDepart.text = "";
    codeDepart.text = "";
    streetLivraison.text = "";
    codeLivraison.text = "";
    descreption.text = "";
  }

  @override
  Widget build(BuildContext context) {
    print(
        "regionController.delegationName.value, ${regionController.delegationName}");
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: Column(children: [
          SizedBox(
            height: 170,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: MyData.localType().length,
              itemBuilder: (BuildContext context, int index) {
                final placeType = MyData.localType()[index];
                return PlaceTypeContainer(
                  imgPath: "assets/images/${placeType.imgPath}.png",
                  placeText: placeType.name,
                  onSelect: (selectedPlaceName) {
                    print("Selected place name: $selectedPlaceName");
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              TextTitile(
                title: "Nom",
              ),
            ],
          ),

          MyTextField(
            right: 5,
            buttom: 8,
            fixIconBool: false,
            hitTextSize: 18,
            controller: nom,
            hintText: 'ex. Pc Portable',
            keyboardType: TextInputType.text,
          ),

          Row(
            children: [
              TextTitile(
                title: "Prix",
              ),
            ],
          ),
          MyTextField(
            right: 5,
            buttom: 8,
            fixIconBool: true,
            iconColor: AppColors.primary,
            icon: const Icon(Icons.monetization_on_outlined),
            hitTextSize: 18,
            controller: prix,
            hintText: 'ex. 5Dt',
            keyboardType: TextInputType.number,
          ),
//DEPARTURE ADDRESS
          Row(
            children: [
              TextTitile(
                title: translation(context).departure_address,
              ),
            ],
          ),

          AddressSectionWidget(
            title: "${translation(context).street} :",
            widget: MyTextField(
              // left: 5,
              right: 5,
              buttom: 8,
              width: 50,
              iconColor: AppColors.primary,
              icon: const Icon(Icons.location_on_outlined),
              hitTextSize: 18,
              controller: streetDepart,
              hintText: 'ex. 17, imm.kornich',
              keyboardType: TextInputType.streetAddress,
            ),
          ),

          AddressSectionWidget(
              title: "${translation(context).city} :",
              widget: Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 12),
                child: Obx(() => DropDownButtonWidget(
                      hintText: 'Select City',
                      items: (regionController.regionNames.value.isEmpty)
                          ? ['wait data']
                          : regionController.regionNames.value,
                      selectedValue: cityDepart,
                      itemSelect: (String? value) async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        setState(() {
                          cityDepart = value;
                          prefs.setString("city", value!);
                          print('value ********$value');
                          stateDepart = null;
                        });
                        regionController.getDelegationsNames(value!);
                      },
                    )),
              )),
          AddressSectionWidget(
            title: "${translation(context).state} :",
            widget: Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 12),
                child: Obx(
                  () => DropDownButtonWidget(
                    items: (regionController.delegationName.value.isEmpty)
                        ? []
                        : regionController.delegationName.value,
                    hintText: translation(context).select_state,
                    selectedValue: stateDepart,
                    itemSelect: (String? value) {
                      setState(() {
                        stateDepart = value;
                      });
                    },
                  ),
                )),
          ),

          AddressSectionWidget(
            title: "${translation(context).postal_code} :",
            widget: MyTextField(
              right: 5,
              buttom: 8,
              fixIconBool: false,
              hitTextSize: 18,
              controller: codeDepart,
              hintText: 'ex. 5090',
              keyboardType: TextInputType.number,
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          //livraison Address
          Row(
            children: [
              TextTitile(
                title: translation(context).livraison_address,
              ),
            ],
          ),
// LIVRAISON ADDRESS
          AddressSectionWidget(
            title: "${translation(context).street} :",
            widget: MyTextField(
              right: 5,
              buttom: 8,
              iconColor: AppColors.primary,
              icon: const Icon(Icons.location_on_outlined),
              hitTextSize: 18,
              controller: streetLivraison,
              hintText: 'ex. 17, imm.kornich',
              keyboardType: TextInputType.text,
            ),
          ),

          AddressSectionWidget(
            title: "${translation(context).city} :",
            widget: Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 12),
                child: Obx(
                  () => DropDownButtonWidget(
                    items: regionController.regionNames.value,
                    hintText: translation(context).select_state,
                    selectedValue: cityLivraison,
                    itemSelect: (String? value) async {
                      setState(() {
                        cityLivraison = value;
                        stateLivraison = null;
                      });
                      regionController.getLivDelegationsNames(value!);
                    },
                  ),
                )),
          ),

          AddressSectionWidget(
            title: "${translation(context).state} :",
            widget: Padding(
                padding: const EdgeInsets.only(right: 5, bottom: 12),
                child: Obx(
                  () => DropDownButtonWidget(
                    items: regionController.delegationLivName.value,
                    hintText: translation(context).select_state,
                    selectedValue: stateLivraison,
                    itemSelect: (String? value) {
                      setState(() {
                        stateLivraison = value;
                      });
                    },
                  ),
                )),
          ),

          AddressSectionWidget(
            title: "${translation(context).postal_code} :",
            widget: MyTextField(
              right: 5,
              buttom: 8,
              fixIconBool: false,
              hitTextSize: 18,
              controller: codeLivraison,
              keyboardType: TextInputType.number,
              hintText: 'ex. 5090',
            ),
          ),

          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              MyTextField(
                buttom: 8,
                height: 150,
                left: 10,
                fixIconBool: false,
                maxline: 4,
                controller: descreption,
                hitTextSize: 18,
                hintText: translation(context).description,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 190),
            child: ButtonElevationWidget(
              backgroundColor: AppColors.white,
              titel: translation(context).add_order,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: AppColors.white,
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextTitile(
                            title: translation(context).departure_address,
                          ),
                          Text(
                              '${streetDepart.text}, $cityDepart ${codeDepart.text}, $stateDepart Tunisia'),
                          TextTitile(
                              title: translation(context).livraison_address),
                          Text(
                              '${streetLivraison.text}, $cityLivraison ${codeLivraison.text}, $stateLivraison Tunisia'),
                        ],
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ButtonElevationWidget(
                                width: 80,
                                titel: translation(context).ok,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            ButtonElevationWidget(
                                width: 80,
                                textColor: AppColors.white,
                                backgroundColor: AppColors.primary,
                                titel: translation(context).yes,
                                onPressed: () async {
                                  handleAddOrder();
                                }),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            ),
          )
        ]),
      ),
    );
  }

  void clearFields() {
    stateDepart = null;
    streetDepart.clear();
    cityDepart = null;
    streetLivraison.clear();
    cityLivraison = null;
    stateLivraison = null;
    descreption.clear();
    codeDepart.clear();
    codeLivraison.clear();
    nom.clear();
    prix.clear();
  }

  Future<void> handleAddOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final orderModel = OrderModel(
        departureAddress: AddressModel(
          street: streetDepart.text,
          city: cityDepart,
          state: stateDepart,
          postalCode: int.parse(codeDepart.text),
        ),
        deliveryAddress: AddressModel(
          street: streetLivraison.text,
          city: cityLivraison,
          state: stateLivraison,
          postalCode: int.parse(codeLivraison.text),
        ),
        nom : nom.text,
        prix: int.parse(prix.text),
        description: descreption.text,
        status: Status.processing.intValue,
        client: User(
          id: prefs.getString("clientId"),
        ));
    print("client id is ${prefs.getString("clientId")}");
    orderController.createOrder(orderModel);
    clearFields();
    Navigator.of(context).pop();
  }
}
