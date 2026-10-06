import 'package:b2b_app/view/pages/accueil_page.dart';
import 'package:b2b_app/view/pages/cart_page.dart';
import 'package:b2b_app/view/pages/catalog_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../utils/app_colors.dart';
import 'history_page.dart';
import 'profilePage.dart';
import '../widgets/build_nav_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPagetState createState() => MainPagetState();
}

class MainPagetState extends State<MainPage> {
  int pageIndex = 2;
  final GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  final CartController cartController = Get.put(CartController());



  @override
void initState() {
  super.initState();
  final cartController = Get.find<CartController>();
  cartController.getCart(); 
}

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      ProfilPage(),
      CatalogPage(),
      AcceuilPage(onNavigateToPage: changePage),
      CartPage(onNavigateToPage: changePage),
      HistoryPage(),
    ];
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        index: pageIndex,
        items: <Widget>[
          BuildNavItem(
            iconData: FontAwesomeIcons.user,
            index: 0,
            selectedIndex: pageIndex,
          ),
          BuildNavItem(
            iconData: Icons.menu_book,
            index: 1,
            selectedIndex: pageIndex,
          ),
          BuildNavItem(
            iconData: Icons.home,
            index: 2,
            selectedIndex: pageIndex,
          ),
          Obx(() {
  int itemCount = cartController.itemsCoun.value;
  return itemCount > 0
      ? badges.Badge(
          position: badges.BadgePosition.topEnd(top: -11, end: -8),
          badgeContent: Text(
            itemCount.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          badgeAnimation: badges.BadgeAnimation.rotation(
            animationDuration: Duration(seconds: 1),
            colorChangeAnimationDuration: Duration(seconds: 1),
            loopAnimation: false,
            curve: Curves.fastOutSlowIn,
            colorChangeAnimationCurve: Curves.easeInCubic,
          ),
          badgeStyle: badges.BadgeStyle(
            badgeColor: AppColors.second,
            padding: EdgeInsets.all(5),
          ),
          child: BuildNavItem(
            iconData: Icons.shopping_cart,
            index: 3,
            selectedIndex: pageIndex,
          ),
        )
      : BuildNavItem(
          iconData: Icons.shopping_cart,
          index: 3,
          selectedIndex: pageIndex,
        );
}),


          BuildNavItem(
            iconData: FontAwesomeIcons.clockRotateLeft,
            index: 4,
            selectedIndex: pageIndex,
          ),
        ],
        color: AppColors.primary,
        buttonBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: pages[pageIndex],
    );
  }

  void changePage(int newIndex) {
    print('Changing to page index: $newIndex');
    setState(() {
      pageIndex = newIndex;
      bottomNavigationKey.currentState?.setPage(newIndex);
    });
  }
}
