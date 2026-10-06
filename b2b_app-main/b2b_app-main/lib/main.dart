import 'package:b2b_app/controller/cart_controller.dart';
import 'package:b2b_app/utils/page_routes.dart';
import 'package:b2b_app/view/pages/command_detail_page.dart';
import 'package:b2b_app/view/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'view/pages/detail_produit_page.dart';
import 'view/pages/login_page.dart';
import 'view/pages/produit_simiailair.dart';
import 'view/pages/main_page.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  Get.put(CartController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,


      builder: (context, child){
        return GetMaterialApp(
        debugShowCheckedModeBanner: false,
  
       initialRoute: loginPage,
      getPages: [
        GetPage(name: splashPage, page: () => SplashPage()),
        GetPage(name: loginPage, page: () => LoginPage()),
        GetPage(name: proiduitSemailairPage, page: () => ProiduitSimiailair()),
        GetPage(name: detailProduitPage, page: () => DetailProduitPage()),
        GetPage(name: mainPage, page: () => MainPage()),
        GetPage(name: commandDetailPage, page: () => CommandDetailPage()),
      ],
      );
      },
    );
  }
}
