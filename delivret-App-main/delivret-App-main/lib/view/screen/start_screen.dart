import 'package:deliveryapp/utils/app_colors.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:deliveryapp/utils/page_routes.dart';
import 'package:deliveryapp/view/widgets/elevation_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  StartScreenState createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              "assets/images/Logo.png",
              height: 200,
              width: 350,
            )),
            const SizedBox(
              height: 20,
            ),
            ButtonElevationWidget(
              titel: translation(context).as_user,
              backgroundColor: AppColors.third,
              textColor: AppColors.white,
              borderColor: AppColors.third,
              width: 250,
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('user', "client");
                print("${prefs.getString('user')}");
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, loginScreen);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonElevationWidget(
              titel: translation(context).as_Delivery,
              backgroundColor: AppColors.white,
              textColor: AppColors.third,
              borderColor: AppColors.third,
              width: 250,
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('user', "livreur");
                print("${prefs.getString('user')}");
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, loginScreen);
              },
            )
          ],
        ));
  }
}
