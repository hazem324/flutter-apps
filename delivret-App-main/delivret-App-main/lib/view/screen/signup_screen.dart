import 'package:deliveryapp/utils/language_constant.dart';
import 'package:deliveryapp/view/screen/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/custom_navigation.dart';
import '../widgets/elevation_button_widget.dart';
import '../widgets/header_container.dart';
import '../widgets/password_field_widget.dart';
import '../widgets/rich_text_widget.dart';
import '../widgets/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController adresse = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                HeaderContainer(
                  text: translation(context).create_account,
                ),
                const SizedBox(height: 40),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.white,
                  child: Container(
                    color: AppColors.white,
                    margin: const EdgeInsets.only(
                        top: 10, left: 5, right: 5, bottom: 10),
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    height: 350,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        MyTextField(
                          controller: firstName,
                          hintText: translation(context).first_name,
                          icon: const Icon(Icons.person),
                          iconColor: AppColors.second,
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(height: 5),
                        MyTextField(
                          controller: lastName,
                          hintText: translation(context).family_name,
                          icon: const Icon(Icons.person),
                          iconColor: AppColors.second,
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(height: 5),
                        MyTextField(
                          controller: phone,
                          hintText: translation(context).phone_number,
                          icon: const Icon(Icons.phone),
                          iconColor: AppColors.second,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 5),
                        const SizedBox(height: 5),
                        MyTextField(
                          controller: email,
                          hintText: 'Adresse E-mail',
                          icon: const Icon(Icons.email_outlined),
                          iconColor: AppColors.second,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PassWordField(
                          controller: password,
                          hintText: translation(context).passWord,
                          //  obscureText: true,
                          icon: const Icon(Icons.password_outlined),
                          iconColor: AppColors.second,
                        ),
                      ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextWidget(
                  firstText: translation(context).have_account,
                  secondText: translation(context).login,
                  function: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonElevationWidget(
                  titel: '   ${translation(context).signup}   ',
                  onPressed: () async {
                    int? statusCode = await userController.sendCode(email.text);
                    if (statusCode == 200) {
                      Navigator.of(context).push(CustomPageTransition(
                          child: VerificationScreen(
                        firstName: firstName.text,
                        lastName: lastName.text,
                        email: email.text,
                        phone: phone.text,
                        password: password.text,
                      )));
                      clearFields();
                    } else if (statusCode == 409) {
                      print('user already exist');
                    } else {
                      print("server error ");
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }

  void clearFields() {
    firstName.clear();
    lastName.clear();
    email.clear();
    phone.clear();
    adresse.clear();
    password.clear();
  }
}
