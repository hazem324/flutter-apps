import 'package:deliveryapp/controller/chat_controller.dart';
import 'package:deliveryapp/model/order_model.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:deliveryapp/view/widgets/text_subtitle_widget.dart';
import 'package:deliveryapp/view/widgets/text_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_colors.dart';
import '../../utils/custom_navigation.dart';
import 'chat_conversation_screen.dart';

class OrderInfoScreen extends StatelessWidget {
  final OrderModel order;

  OrderInfoScreen({
    required this.order,
  });
  @override
  Widget build(BuildContext context) {
    ChatController chatController = Get.put(ChatController());

    var departureAddress = order.departureAddress;
    var deliveryAddress = order.deliveryAddress;
    var client = order.client;
    var livreur = order.livreur;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
         
          body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: AppColors.third,
          ),
          Positioned(
            top: screenHeight / 20.3,
            left: screenwidth / 49.04,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: screenHeight / 33.70,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
              top: screenHeight / 8.91,
              child: Container(
                padding: EdgeInsets.only(
                    top: screenHeight / 40.4,
                    right: screenwidth / 39.27,
                    left: screenwidth / 39.27,
                    bottom: screenHeight / 40.4),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(screenHeight / 26.8),
                        topRight: Radius.circular(screenHeight / 26.8)),
                    color: AppColors.white),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextTitile(
                            title: "Colis Name : ",
                            fontWeight: FontWeight.w600,
                          ),
                          Expanded(
                            child: TextSubTitile(
                              subTitle: "${order.nom}",
                              fontSize: screenHeight / 50.25,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextTitile(
                            title: "Prix : ",
                            fontWeight: FontWeight.w600,
                          ),
                          Expanded(
                            child: TextSubTitile(
                              subTitle: "${order.prix} DT",
                              fontSize: screenHeight / 50.25,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextTitile(
                            title: translation(context).departure_address,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      TextSubTitile(
                        subTitle:
                            '${departureAddress!.street}, ${departureAddress.postalCode} ${departureAddress.city}, ${departureAddress.state}',
                        fontSize: screenHeight / 50.25,
                        fontWeight: FontWeight.w400,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextTitile(
                              fontWeight: FontWeight.w600,
                              title: translation(context).livraison_address),
                        ],
                      ),
                      TextSubTitile(
                        subTitle:
                            '${deliveryAddress!.street}, ${deliveryAddress.postalCode} ${deliveryAddress.city}, ${deliveryAddress.state}',
                        fontSize: screenHeight / 50.25,
                        fontWeight: FontWeight.w400,
                      ),
                      Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextTitile(
                            title: translation(context).details,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      TextSubTitile(
                        subTitle: order.description ?? "", // description!,
                        fontSize: screenHeight / 50.25,
                        fontWeight: FontWeight.w400,
                      ),
                      Row(
                        children: [
                          TextTitile(
                            title: translation(context).client_fullName,
                            fontWeight: FontWeight.w600,
                          ),
                          TextSubTitile(
                            subTitle: "${client.nom} ${client.prenom}",
                            fontSize: screenHeight / 50.25,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextTitile(
                            title: translation(context).phone_number,
                            fontWeight: FontWeight.w600,
                          ),
                         
                          TextSubTitile(
                            subTitle: "${client.phoneNum}",
                            fontSize: screenHeight / 50.25,
                            fontWeight: FontWeight.w400,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 5, ),
                            child: IconButton(
                                onPressed: () async {
                                  await makePhoneCall("${client.phoneNum}");
                                },
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.green,
                                  size: screenHeight / 33.7,
                                )),
                          )
                        ],
                      ),
                      (order.status == 0)
                          ? const SizedBox()
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          chatController.getConversation(
                                              client.id ?? "", livreur?.id ?? "");
                                          Navigator.of(context)
                                              .push(CustomPageTransition(
                                                  child: ChatConversationScreen(
                                            sourceId: order.livreur?.id ?? '',
                                            targetId: order.client.id ?? "", userName: '${order.client.nom ?? ""} ${order.client.prenom ?? ""}',
                                          )));
                                        },
                                        icon: const Icon(Icons.wechat_outlined,
                                            color: Colors.green, size: 30)),
                                  ]))
                    ]),
              ))
        ],
      )),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUrl(launchUri);
    } catch (e) {
      print("call error $launchUri error is $e");
    }
  }
}
