import 'package:deliveryapp/model/order_model.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import '../../utils/const_string.dart';

class UserContainer extends StatelessWidget {
  final String? colisName;
  
  final OrderModel order;
  final void Function() function;
  const UserContainer(
      {super.key,
      required this.order,
      required this.colisName,
      required this.function,
      });
  @override
  Widget build(BuildContext context) {
   
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
        child: Container(
            // height: 170,
            width: screenWidth,
            margin: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  colisName ?? "",
                  style: GoogleFonts.arvo(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      translation(context).delivred_by,
                      style: GoogleFonts.arvo(
                          fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: (order.livreur?.imgUrl == null ||
                              order.livreur!.imgUrl == 'http://192.168.1.13:5000null' ||
                              order.livreur!.imgUrl!.isEmpty)
                          ? const AssetImage("assets/images/userProfile.png")
                          : NetworkImage("$ServerUrl${order.livreur?.imgUrl}")
                              as ImageProvider<Object>,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "FullName :",
                                style: GoogleFonts.arvo(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text("${order.livreur?.nom ?? ""} ${order.livreur?.prenom ?? ""}" ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Text(
                                translation(context).phone_number,
                                style: GoogleFonts.arvo(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(order.livreur?.phoneNum.toString() ?? ""),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  (order.status != 0)?  IconButton(
                        onPressed: function,
                        icon: const Icon(Icons.wechat_outlined,
                            color: Colors.green, size: 30)) : SizedBox(),
                  ],
                ),
              ],
            )));
  }
}
