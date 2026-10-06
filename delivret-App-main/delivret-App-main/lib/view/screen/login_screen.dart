// ignore_for_file: use_build_context_synchronously

import 'package:deliveryapp/utils/custom_navigation.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:deliveryapp/view/screen/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/user_controller.dart';
import '../widgets/elevation_button_widget.dart';
import '../widgets/header_container.dart';
import '../widgets/notosans_text_widget.dart';
import '../widgets/password_field_widget.dart';
import '../widgets/rich_text_widget.dart';
import '../widgets/text_field_widget.dart';
import 'package:deliveryapp/utils/app_colors.dart';
import 'package:deliveryapp/utils/page_routes.dart';

import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderContainer(
              text: translation(context).login,
            ),
             SizedBox(
              height: screenHeight/53.93,
            ),
            Container(
              margin:  EdgeInsets.only(left: screenWidth/19.63,  right: screenWidth/19.63, top: screenHeight/26.8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Material(
                    elevation: screenHeight/160.08,
                    borderRadius: BorderRadius.circular( screenHeight/40.4),
                    color: AppColors.white,
                    child: Container(
                      height: screenHeight/4.01,
                      margin:  EdgeInsets.all(screenHeight/160.08,),
                      color: AppColors.white,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyTextField(
                             left: screenWidth/19.63,
                              right: screenWidth/19.63,
                              controller: email,
                              hintText: 'Adresse E-mail',
                              icon: const Icon(Icons.email_outlined),
                              iconColor: AppColors.second,
                              keyboardType: TextInputType.emailAddress,
                            ),
                             SizedBox(
                              height: screenHeight/53.93,
                            ),
                            PassWordField(
                              left: screenWidth/19.63,
                              right: screenWidth/19.63,
                              controller: password,
                              hintText: translation(context).passWord,
                              icon: const Icon(Icons.password_outlined),
                              iconColor: AppColors.second,
                            ),
                          ]),
                    ),
                  ),
                   SizedBox(
                    height: screenHeight/40.4,
                  ),
                  TextWidget(
                    firstText: translation(context).dont_have_an_account,
                    secondText: translation(context).signup,
                    function: () {
                      Navigator.of(context)
                          .push(CustomPageTransition(child: SignUpScreen()));
                    },
                  ),
                   SizedBox(
                    height: screenHeight/22.94,
                  ),
                  ButtonElevationWidget(
                    titel: translation(context).login,
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await userController.login(email.text, password.text);
                      String? errorMessage =
                          await userController.login(email.text, password.text);
                      if (errorMessage == null) {
                        if (prefs.getString('user') == 'client') {
                          Navigator.pushNamed(
                            context,
                            clientHomeScreen,
                          );
                        } else {
                          Navigator.pushNamed(context, livreurHomeScreen);
                        }

                        email.clear();
                        password.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            elevation: screenHeight/80.2,
                            backgroundColor: AppColors.red,
                            content: Text(errorMessage),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: screenHeight/40.2),
                  GestureDetector(
                    onTap: ()=> Navigator.of(context)
                          .push(CustomPageTransition(child: const ForgetPasswordScreen(),
                          direction: AxisDirection.up
                          )),
                    child: NotoSansText(
                      colors: AppColors.primary,
                      text: translation(context).forgot_password,
                      size: screenHeight/50.25,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
