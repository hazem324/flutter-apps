import 'package:deliveryapp/utils/language_constant.dart';
import 'package:deliveryapp/view/screen/chat_conversation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/chat_controller.dart';
import '../../model/order_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/custom_navigation.dart';
import '../widgets/stepper_widget.dart';
import '../widgets/user_container_widget.dart';

class OrderStatusScreen extends StatefulWidget {
  @override
  OrderStatusScreenState createState() => OrderStatusScreenState();
  final OrderModel order;

  const OrderStatusScreen({
    super.key,
    required this.order,
  });
}

class OrderStatusScreenState extends State<OrderStatusScreen> {
  ChatController chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print("${screenHeight} , ${screenWidth}");
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: Center(
              child: Text(
            translation(context).order_status,
            style: GoogleFonts.montserrat(color: AppColors.white),
          )),
          iconTheme: const IconThemeData(color: AppColors.white),
          flexibleSpace: Container(
              decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.third],
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter),
          )),
        ),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      UserContainer(
                        order: widget.order,
                          colisName: widget.order.nom,
                          function: () async {
                          await  chatController.getConversation(
                                widget.order.client.id ?? "",
                                widget.order.livreur?.id ?? '');
                            print(
                                "client id isss ${widget.order.client.id}       livreur id is ${widget.order.livreur?.id}");
                            Navigator.of(context).push(CustomPageTransition(
                                child: ChatConversationScreen(
                                  
                              sourceId: widget.order.client.id ?? "",
                              targetId: widget.order.livreur?.id ?? '', userName: '${widget.order.livreur?.nom ?? ""} ${widget.order.livreur?.prenom ?? ""}',
                            )));
                          }, ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          StepperWidget(status: widget.order.status),
                        ],
                      )
                    ]),
              ),
            ])));
  }
}
