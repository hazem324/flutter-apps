import 'package:deliveryapp/model/user_model.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:deliveryapp/utils/page_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/user_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/const_string.dart';
import '../../utils/custom_navigation.dart';
import '../screen/profile_screen.dart';
import 'costom_alert_dialog_widget.dart';
import 'language_drop_down_widget.dart';
import 'text_subtitle_widget.dart';

class DrawerWidget extends StatefulWidget {
  @override
  DrawerWidgetState createState() => DrawerWidgetState();
}

class DrawerWidgetState extends State<DrawerWidget> {
  UserController userController = Get.put(UserController());
  @override
  void initState() {
    super.initState();
    userController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    List<UserModel> userInfo = userController.userInfor;
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.70,
      backgroundColor: AppColors.white,
      elevation: 30,
      child: ListView(children: [
        UserAccountsDrawerHeader(
          accountName: Text(
            "${userInfo.first.firstName} ${userInfo.first.lastName}",
            style: GoogleFonts.merriweather(color: AppColors.white),
          ),
          accountEmail: Text(
            "${userInfo.first.email}",
            style: const TextStyle(color: AppColors.white),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: (userInfo.first.imageUrl == "null" ||
                    userInfo.first.imageUrl.toString().isEmpty)
                ? const AssetImage("assets/images/userProfile.png")
                : NetworkImage(
                        "$ServerUrl${userInfo.first.imageUrl.toString()}")
                    as ImageProvider<Object>,
          ),
          decoration: const BoxDecoration(
            color: AppColors.third,
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          title: TextSubTitile(
            subTitle: translation(context).home,
            textColor: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.settings,
            size: 30,
            color: Colors.black,
          ),
          title: TextSubTitile(
            subTitle: translation(context).profile,
            textColor: Colors.black,
          ),
          onTap: () {
            print(
                '88888888888888888888888888888888888888888${userInfo.first.imageUrl}');
            Navigator.of(context).push(CustomPageTransition(
                child: ProfileScreen(
                  firstName: userInfo.first.firstName,
                  lastName: userInfo.first.lastName,
                  phoneNum: userInfo.first.phone.toString(),
                  email: userInfo.first.email,
                  imageUrl: "${userInfo.first.imageUrl}",
                ),
                direction: AxisDirection.left));
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.translate_outlined,
            size: 30,
            color: Colors.black,
          ),
          title: LanguageDropDownWidget(),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.logout_rounded,
            size: 30,
            color: Colors.black,
          ),
          title: TextSubTitile(
            subTitle: 'LogOut',
            textColor: Colors.black,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomAlertDialog(
                  title: translation(context).log_out,
                  content: TextSubTitile(
                      subTitle: translation(context).want_to_sign_out),
                  confirmButtonText: translation(context).yes,
                  onConfirmPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await userController.logOut(); 
                    String logoutMessage = prefs.getString("logout") ?? "";
                    if (logoutMessage == "Logout successful") {
                      await prefs.clear();
                      Navigator.pushNamed(context, startScreen);
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                );
              },
            );
          },
        )
      ]),
    );
  }
}
