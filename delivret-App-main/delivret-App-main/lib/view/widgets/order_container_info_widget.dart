import 'package:deliveryapp/utils/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/order_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/order_status_enum.dart';
import 'text_subtitle_widget.dart';
import 'text_title_widget.dart';

class OrderContainer extends StatefulWidget {
  @override
  OrderContainerState createState() => OrderContainerState();

  final OrderModel order;
  final int index;
  final Function takeInCharge;
  OrderContainer({
    required this.order,
    required this.index,
    required this.takeInCharge,
  });
}

class OrderContainerState extends State<OrderContainer> {
  bool addButton = false;
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var departureAddress = widget.order.departureAddress;
    var deliveryAddress = widget.order.deliveryAddress;
    var client = widget.order.client;
    return AnimatedContainer(
        duration: Duration(milliseconds: 300 + (widget.index * 200)),
        transform: Matrix4.translationValues(
            startAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
        curve: Curves.fastOutSlowIn,
        child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(bottom: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.containerColor,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0.5, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextTitile(
                  title: "Order N° ${widget.index}: ",
                  fontWeight: FontWeight.w700,
                ),
                TextSubTitile(
                  subTitle: ' - ${translation(context).departure_address}',
                  fontWeight: FontWeight.w500,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(
                    '${departureAddress!.street}, ${departureAddress.postalCode} ${departureAddress.city}, ${departureAddress.state}',
                    style: GoogleFonts.inconsolata(fontSize: 18),
                  ),
                ),
                TextSubTitile(
                  subTitle: '- ${translation(context).livraison_address}',
                  fontWeight: FontWeight.w500,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Text(
                    '${deliveryAddress!.street}, ${deliveryAddress.postalCode} ${deliveryAddress.city}, ${deliveryAddress.state}',
                    style: GoogleFonts.inconsolata(fontSize: 18),
                  ),
                ),
                Row(
                  children: [
                    TextSubTitile(
                      subTitle: '- ${translation(context).status} :',
                      fontWeight: FontWeight.w500,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(Status.orderStatus(widget.order.status),
                          style: GoogleFonts.merriweather(
                            fontSize: 15,
                          )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextSubTitile(
                      subTitle: '- ${translation(context).client_fullName}',
                      fontWeight: FontWeight.w500,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("${client.nom} ${client.prenom}",
                          style: GoogleFonts.merriweather(
                            fontSize: 15,
                          )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextSubTitile(
                      subTitle: '- ${translation(context).phone_number}',
                      fontWeight: FontWeight.w500,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(client.phoneNum.toString(),
                          style: GoogleFonts.merriweather(
                            fontSize: 15,
                          )),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: IconButton(
                          onPressed: () {
                            addButton = !addButton;
                            setState(() {});
                          },
                          icon: Icon((addButton)
                              ? Icons.arrow_drop_up_outlined
                              : Icons.arrow_drop_down_outlined)),
                    ),
                  ],
                ),
                if (addButton)
                  GestureDetector(
                    onTap: () {
                      widget.takeInCharge();
                    },
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                      width: 300,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Text(
                        translation(context).add,
                        style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      )),
                    ),
                  ),
              ],
            )));
  }
}
