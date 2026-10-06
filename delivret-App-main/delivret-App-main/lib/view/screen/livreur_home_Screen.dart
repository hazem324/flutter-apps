import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/livreur_order_list.dart';
import '../widgets/order_list_widget.dart';

class LivreurHomeScreen extends StatefulWidget {
  @override
  LivreurHomeScreenState createState() => LivreurHomeScreenState();
}

class LivreurHomeScreenState extends State<LivreurHomeScreen> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
      drawer: DrawerWidget(),
      body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            OrderListWidget(),
            LivreurOrderList(),
          ]),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.third,
        buttonBackgroundColor: AppColors.white,
        color: AppColors.containerColor,
        height: screenHeight / 16.08,
        items: <Widget>[
          Icon(
            Icons.format_list_bulleted,
            size: screenHeight / 26.8,
            color: AppColors.primary,
          ),
          Icon(
            Icons.checklist_outlined,
            size: screenHeight / 26.8,
            color: AppColors.primary,
          )
        ],
        onTap: (index) {
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
      ),
    );
  }
}
