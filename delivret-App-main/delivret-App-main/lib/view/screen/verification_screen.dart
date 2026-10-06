import 'package:deliveryapp/utils/app_colors.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:deliveryapp/view/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../../model/user_model.dart';
import '../../utils/custom_navigation.dart';
import '../widgets/costum_pin_code_widget.dart';
import '../widgets/custom_tost_widget.dart';
import '../widgets/elevation_button_widget.dart';

class VerificationScreen extends StatefulWidget {
  @override
  VerificationScreenState createState() => VerificationScreenState();

  final String? firstName;
  final String? lastName;
  final String phone;
  final String? email;
  final String? password;

  VerificationScreen(
      {required this.firstName,
      required this.lastName,
      required this.phone,
      required this.email,
      required this.password});
}

class VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController pinCode = TextEditingController();

  UserController userController = Get.put(UserController());
final tost = FToast();

  @override
  void initState() {
    super.initState();

    tost.init(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
          body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/otpVerification.png',
                height: 250,
                width: 200,
              ),
              Text(
                translation(context).entre_verification_code,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                translation(context).code_send,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 15),
              CustomPinFiled(controller: pinCode),
              ButtonElevationWidget(
                titel: translation(context).verify,
                onPressed: () {
                  final userModel = UserModel(
                      firstName: widget.firstName,
                      lastName: widget.lastName,
                      email:widget.email,
                      phone:int.parse(widget.phone),
                      password: widget.password,
                      pinCode: pinCode.text);
               var msg =   userController.signUp(userModel);
                tost.showToast(
            child: CustomTostWidget(text: msg.toString()),
            gravity: ToastGravity.BOTTOM);
                  Navigator.of(context).push(CustomPageTransition(child: LoginScreen()));
                },
                textColor: AppColors.white,
                backgroundColor: AppColors.primary,
                height: 65,
                width: 230,
              )
            ],
          ),
        ),
      )),
    );
  }
}
