// ignore_for_file: use_build_context_synchronously

import 'package:deliveryapp/controller/user_controller.dart';
import 'package:deliveryapp/utils/app_colors.dart';
import 'package:deliveryapp/utils/const_string.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../widgets/custom_tost_widget.dart';
import '../widgets/elevation_button_widget.dart';
import '../widgets/password_field_widget.dart';
import '../widgets/phone_change_widget.dart';
import '../widgets/profile_container.dart';
import '../widgets/profile_image.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();

  final String? firstName;
  final String? lastName;
  final String? phoneNum;
  final String? email;
  final String? imageUrl;
  ProfileScreen(
      {required this.firstName,
      required this.lastName,
      required this.phoneNum,
      required this.email,
      required this.imageUrl});
}

class ProfileScreenState extends State<ProfileScreen> {
  UserController userController = Get.put(UserController());

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confPassword = TextEditingController();

  final tost = FToast();

  @override
  void initState() {
    super.initState();
    userController.getUser();
    tost.init(context);
  }

  @override
  Widget build(BuildContext context) {
    print('**********************$ServerUrl${widget.imageUrl.toString()}');
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    print("${MediaQuery.of(context).size.width}");
    print("$screenHeight");
    return Scaffold(
      body: Container(
        color: AppColors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: screenHeight / 3.64,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.third],
                    end: Alignment.bottomCenter,
                    begin: Alignment.topCenter),
              ),
            ),
            Positioned(
              top: screenHeight / 26.8,
              left: screenWidth / 49.04,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                  size: screenHeight / 32.11,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Positioned(
                top: screenHeight / 6.17,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(screenHeight / 22.94),
                            topRight: Radius.circular(screenHeight / 22.94))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight / 8.9),
                        ProfileContainer(
                          title:translation(context).first_name,
                          subtitle: widget.firstName,
                        ),
                        SizedBox(height: screenHeight / 114.7),
                        ProfileContainer(
                          title: translation(context).family_name,
                          subtitle: widget.lastName,
                        ),
                        SizedBox(height: screenHeight / 114.7),
                        PhoneContainer(
                          title: translation(context).phone_number,
                          subtitle: widget.phoneNum,
                        ),
                        SizedBox(height: screenHeight / 114.7),
                        ProfileContainer(
                          title: 'Email :',
                          subtitle: widget.email,
                        ),
                      ],
                    ))),
            Positioned(
                right: screenWidth / 3.21,
                top: screenHeight / 11.48,
                child: ProfileImage(
                  imageUrl: widget.imageUrl.toString(),
                )),
            Positioned(
                bottom: screenHeight / 10.03,
                right: screenWidth / 6.04,
                child: ButtonElevationWidget(
                  titel: translation(context).change_password,
                  onPressed: () => changePassword(),
                  width: screenWidth / 1.51,
                )),
          ],
        ),
      ),
    );
  }

  Future<void> changePassword() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final double screenWidth = MediaQuery.of(context).size.width;
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: Text(translation(context).change_password),
          content: SizedBox(
            height: 210,
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PassWordField(
                  controller: oldPassword,
                  hintText: translation(context).current_password,
                  //  obscureText: true,
                  icon: const Icon(Icons.password_outlined),
                  iconColor: AppColors.second,
                ),
                PassWordField(
                  controller: newPassword,
                  hintText: translation(context).new_password,
                  //  obscureText: true,
                  icon: const Icon(Icons.password_outlined),
                  iconColor: AppColors.second,
                ),
                PassWordField(
                  controller: confPassword,
                  hintText: translation(context).retype_new_password,
                  //  obscureText: true,
                  icon: const Icon(Icons.password_outlined),
                  iconColor: AppColors.second,
                ),
              ],
            ),
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
                  onPressed: () => confirmNewPassword(),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void confirmNewPassword() async {
    if (newPassword.text == confPassword.text) {
      int? statusCode = await userController.changePassWord(
          oldPassword.text, newPassword.text);
      print('change pass word status code $statusCode');
      if (statusCode == 200) {
        tost.showToast(
            child: CustomTostWidget(text: translation(context).password_succ),
            gravity: ToastGravity.BOTTOM);
        userController.getUser();
        setState(() {});
        oldPassword.clear();
        newPassword.clear();
        confPassword.clear();
      } else if (statusCode == 401) {
        tost.showToast(
            child: CustomTostWidget(text: translation(context).pass_incor),
            gravity: ToastGravity.BOTTOM);
      } else {
        tost.showToast(
            child:
                CustomTostWidget(text: translation(context).password_failed),
            gravity: ToastGravity.BOTTOM);
      }
    } else {
      tost.showToast(
          child: CustomTostWidget(text: translation(context).password_verf),
          gravity: ToastGravity.BOTTOM);
    }
  }
}
