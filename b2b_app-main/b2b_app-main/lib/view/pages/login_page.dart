import 'package:b2b_app/utils/app_colors.dart';
import 'package:b2b_app/view/widgets/circular_progressindicator.dart';
import 'package:b2b_app/view/widgets/text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../../utils/page_routes.dart';
import '../../utils/snack_bar_error.dart';
import '../widgets/password_text_filed.dart';
import '../widgets/primary_button.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Obx(() {
        return SafeArea(
          child: userController.isLoading.value
              ?  Center(child: CustomCircularIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/logo-t.png",
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: MediaQuery.of(context).size.height / 5,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 32.h,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              "Bienvenue chez SOGEPAM ! Connectez-vous pour continuer.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CustomTextFiled(
                            keyboardType: TextInputType.emailAddress,
                            icon: Icons.email_outlined,
                            hintText: 'Entre votre e-mail adress',
                            controller: email,
                          ),
                          CustomPasswordField(
                            hintText: 'Enter votre mot de passe',
                            controller: password,
                          ),
                          SizedBox(height: 25.h),
                          PrimaryButton(
                            title: 'Login',
                            height: 45.h,
                            onPressed: () async {
                              final String emailText = email.text.trim();
                              final String passwordText = password.text.trim();

                              if (emailText.isEmpty || passwordText.isEmpty) {
                                SnackbarError.showError(
                                  "Champs requis",
                                  "Veuillez remplir l'e-mail et le mot de passe.",
                                );
                                return;
                              }

                              await userController.loginUser(emailText, passwordText);

                              if (userController.isLoged.value) {
                                Navigator.pushReplacementNamed(context, mainPage);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      }),
    );
  }
}
