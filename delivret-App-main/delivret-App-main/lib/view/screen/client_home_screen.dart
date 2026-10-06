import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:deliveryapp/view/widgets/add_order_widget.dart';
import 'package:deliveryapp/view/widgets/client_order_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../../utils/app_colors.dart';
import '../widgets/drawer_widget.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});
  @override
  ClientHomeScreenState createState() => ClientHomeScreenState();
}

class ClientHomeScreenState extends State<ClientHomeScreen> {
  final _pageController = PageController();
  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    userController.getUser();
    _pageController.addListener(() {
      setState(() {});
    });
    initializeAwesomeNotifications();
  }

  @override
  Widget build(BuildContext context) {
      final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: AppColors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.white),
        flexibleSpace: Container(
            decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.third],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter),
        )),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          const AddOrderScrenn(),
          MyOrderScreen(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.third,
        buttonBackgroundColor: AppColors.white,
        color: AppColors.containerColor,
        height: screenHeight/16.08,
        items:  <Widget>[
          Icon(
            Icons.add,
            size:  screenHeight/26.8,
            color: AppColors.primary,
          ),
          Icon(
            Icons.format_list_bulleted,
            size: screenHeight/26.8,
            color: AppColors.primary,
          )
        ],
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.removeListener(() {});
    _pageController.dispose();
    super.dispose();
  }

  void initializeAwesomeNotifications() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'high_importance_channel',
          channelName: 'Basic notification',
          channelDescription: 'Notification channnel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          onlyAlertOnce: true,
          playSound: true,
        ),
      ],
      debug: true,
    );
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Enable Notifications'),
              content:
                  const Text('Please enable notifications to receive updates.'),
              actions: <Widget>[
                TextButton(
                  child: Text(translation(context).ok),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Request permission to send notifications
                    AwesomeNotifications()
                        .requestPermissionToSendNotifications();
                  },
                ),
                TextButton(
                  child: Text(translation(context).no),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }
}
