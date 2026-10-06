// ignore_for_file: use_build_context_synchronously

import 'package:deliveryapp/controller/user_controller.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:deliveryapp/view/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/custom_navigation.dart';
import '../widgets/costum_pin_code_widget.dart';
import '../widgets/custom_tost_widget.dart';
import '../widgets/elevation_button_widget.dart';
import '../widgets/notosans_text_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({super.key, required this.email});

  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  UserController userController = Get.put(UserController());
  final TextEditingController pinCode = TextEditingController();
  final tost = FToast();
  @override
  void initState() {
    super.initState();

    tost.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight / 22.94),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.primary,
                    size: screenHeight / 32.11,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight / 80.29),
          Image.asset(
            "assets/images/enterotp.png",
            height: screenHeight / 2.43,
          ),
          SizedBox(height: screenHeight / 80.29),
          NotoSansText(
            text: translation(context).password_send,
            size: screenHeight / 28.15,
          ),
          NotoSansText(
            text: "${translation(context).code_envoye}\n${widget.email}",
            size: screenHeight / 57.35,
            colors: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
          /* SizedBox(
            height: screenHeight / 20.15,
          ),*/
          CustomPinFiled(controller: pinCode),
          ButtonElevationWidget(
            titel: translation(context).res_password,
            width: screenWidth / 1.22,
            onPressed: () async => restPassword(),
          )
        ]),
      ),
    );
  }

  Future<void> restPassword() async {
    int? statusRes =
        await userController.resetPassword(pinCode.text, widget.email);
    if (statusRes == 200) {
      tost.showToast(
          child: CustomTostWidget(text: "Password changed succ"),
          gravity: ToastGravity.BOTTOM);
      Navigator.of(context).push(CustomPageTransition(
          child: LoginScreen(), direction: AxisDirection.up));
    } else if (statusRes == 400) {
      tost.showToast(
          child: CustomTostWidget(text: "incorrect new password"),
          gravity: ToastGravity.BOTTOM);
    } else {
      tost.showToast(
          child: CustomTostWidget(text: "Somthing whent wrrong"),
          gravity: ToastGravity.BOTTOM);
    }
  }
}
