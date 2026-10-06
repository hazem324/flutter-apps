// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/custom_navigation.dart';
import '../../utils/language_constant.dart';
import '../widgets/custom_tost_widget.dart';
import '../widgets/elevation_button_widget.dart';
import '../widgets/notosans_text_widget.dart';
import '../widgets/text_field_widget.dart';
import 'reset_password_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ForgetPasswordScreenState createState() => ForgetPasswordScreenState();
}

class ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final tost = FToast();

  @override
  void initState() {
    super.initState();

    tost.init(context);
  }

  UserController userController = Get.put(UserController());
  final TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    print('width : $screenWidth');
    print("height : $screenHeight");
    return Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
              Image.asset("assets/images/forgetPassword.png"),
              SizedBox(height: screenHeight / 80.29),
              NotoSansText(
                text: translation(context).mot_oblier,
                size: screenHeight / 26.8,
              ),
              NotoSansText(
                text:translation(context).dont_worry,
                size: screenHeight / 57.42,
                colors: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: screenHeight / 20.15,
              ),
              MyTextField(
                left: screenWidth / 39.27,
                right: screenWidth / 39.27,
                width: screenWidth / 1.19,
                controller: email,
                hintText: 'Adresse E-mail',
                icon: const Icon(Icons.email_outlined),
                iconColor: AppColors.second,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: screenHeight / 17.82,
              ),
              ButtonElevationWidget(
                width: screenWidth / 1.22,
                titel: translation(context).submit,
                textColor: AppColors.white,
                backgroundColor: AppColors.primary,
                onPressed: () async =>sendPassword(),
              )
            ],
          ),
        ));
  }

  Future <void> sendPassword() async {
int? statusRes = await userController.forgotPassword(email.text);
                  if (statusRes == 200) {
                    Navigator.of(context).push(CustomPageTransition(
                        child:  ResetPasswordScreen(email: email.text),
                        direction: AxisDirection.down));
                  } else if (statusRes == 404) {
                    tost.showToast(
                        child: CustomTostWidget(
                            text: "User not found with this e-mail addres"),
                        gravity: ToastGravity.BOTTOM);
                  } else {
                    tost.showToast(
                        child: CustomTostWidget(text: "Somthing whent wrrong, Try later"),
                        gravity: ToastGravity.BOTTOM);
                  }
  }
}
