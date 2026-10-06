// ignore_for_file: use_build_context_synchronously

import 'package:deliveryapp/controller/user_controller.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:deliveryapp/view/widgets/text_subtitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import 'custom_tost_widget.dart';
import 'elevation_button_widget.dart';
import 'text_field_widget.dart';

class PhoneContainer extends StatefulWidget {
  @override
  PhoneContainerState createState() => PhoneContainerState();
  final String? title;
  final String? subtitle;

  PhoneContainer({
    required this.title,
    required this.subtitle,
  });
}

class PhoneContainerState extends State<PhoneContainer> {
  UserController userController = Get.put(UserController());

  TextEditingController phone = TextEditingController();
  final tost = FToast();

  @override
  void initState() {
    super.initState();

    tost.init(context);
  }
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    //  final double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: TextSubTitile(
            subTitle: widget.title!,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 5),
          height: 50,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                style: BorderStyle.solid,
                color: AppColors.primary,
                width: 1.2,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.subtitle!,
                style: GoogleFonts.muktaVaani(
                    fontSize: 17, fontWeight: FontWeight.w500),
              ),
              IconButton(
                padding: EdgeInsets.only(bottom: 5),
                icon: Icon(
                  Icons.edit,
                  size: screenHeight / 32.11,
                  color: AppColors.primary,
                ),
                onPressed: () => changePhoneNum(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Future<void> changePhoneNum() async {
    return showDialog<void>(
      context: context,

      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        final double screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          title:  Text(translation(context).phone_change),
          content: MyTextField(
            controller: phone,
            hintText: translation(context).new_phone,
            icon: const Icon(Icons.phone),
            iconColor: AppColors.second,
            keyboardType: TextInputType.phone,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonElevationWidget(
                  width: screenWidth / 4.3,
                  titel: translation(context).ok,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                ButtonElevationWidget(
                  width: screenWidth / 4.3,
                  textColor: AppColors.white,
                  backgroundColor: AppColors.primary,
                  titel: translation(context).change,
                  onPressed: () => changePhoneNumber(),
                ),
              ],
            )
          ],
        );
      },
    );
  }
  void changePhoneNumber () async { 
    if(phone.text.length !=8){
 tost.showToast(
                      child: CustomTostWidget(text:translation(context).numb_lengh), gravity: ToastGravity.BOTTOM);
    } else{
int? statusCode = await userController
                        .changePhoneNum(int.parse(phone.text));
                        print("Status code: $statusCode");
                    if (statusCode == 200) {
                       tost.showToast(
                      child: CustomTostWidget(text:translation(context).phone_succ), gravity: ToastGravity.BOTTOM);
                    } else if (statusCode == 401) {
                       tost.showToast(
                      child: CustomTostWidget(text:translation(context).phone_fail), gravity: ToastGravity.BOTTOM);
       
                     
                    } else {
                       tost.showToast(
                      child: CustomTostWidget(text:translation(context).phone_fail), gravity: ToastGravity.BOTTOM);
       
                    }
                    phone.clear();
                    Navigator.of(context).pop();
    }
    
  }
}
