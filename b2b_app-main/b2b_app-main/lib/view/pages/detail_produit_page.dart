import 'package:b2b_app/utils/app_colors.dart';
import 'package:b2b_app/utils/const_string.dart';
import 'package:b2b_app/utils/page_routes.dart';
import 'package:b2b_app/view/widgets/circular_progressindicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../controller/product_controller.dart';
import '../widgets/price_display.dart';
import '../widgets/product_container_button.dart';
import '../widgets/product_container_makes.dart';
import '../widgets/product_status_badge.dart';
import '../widgets/secondButton.dart';
import '../widgets/tab_bar_section.dart';

class DetailProduitPage extends StatefulWidget {
  @override
  DetailProduitPageState createState() => DetailProduitPageState();
}

class DetailProduitPageState extends State<DetailProduitPage>
    with TickerProviderStateMixin {
  bool firstContainer = true;
  bool secondContainer = false;
  late TabController tabController;

  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      print("Received Product ID: $productId");
      productController.getProduct(id: productId);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

          child: Obx(() {
            if (productController.isLoading.value) {
              return Center(child: CustomCircularIndicator());
            } else if (productController.product.value == null &&
                !productController.isLoading.value) {
              return Center(child: Text(""));
            } else if (productController.errorMessage.isNotEmpty) {
              return Center(
                child: Text(productController.errorMessage.toString()),
              );
            } else {
              final product = productController.product.value;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 28.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
                        horizontal: 4.w,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (product!.file == null)
                              ? Image.asset(
                                  "assets/images/placeHolder-img.jpg",
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  "$BASE_FIlE_URL/${product.file!.url}",
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  fit: BoxFit.fill,
                                ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 48,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  product.designation,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColor,
                                    wordSpacing: 1.2,
                                  ),
                                ),
                              ),

                              ProductStatusBadge(stock: product.quantity),
                            ],
                          ),

                          Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                              vertical: 5.h,
                              horizontal: 12.w,
                            ),
                            child: RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: 'Reference : ',
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 18.h,
                                  fontWeight: FontWeight.w400,
                                  wordSpacing: 1.2.w,
                                ),
                                children: [
                                  TextSpan(
                                    text: product.id,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.1.w,
                                      fontSize: 16.h,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                              horizontal: 12.w,
                            ),

                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.boxesStacked,
                                  color: AppColors.textColor,
                                  size: 16.h,
                                ),
                                Text(
                                  " : ${product.supplier?.name}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.1.w,
                                    fontSize: 16.h,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          product.applications.isNotEmpty
                              ? Center(
                                  child: ProductContainerMakes(
                                    applications: product.applications,
                                    height: 55.h,
                                    width: 55.w,
                                  ),
                                )
                              : SizedBox.shrink(),

                          Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                              horizontal: 12.w,
                              vertical: 5.h,
                            ),
                            child: ProductPriceDisplay(
                              prixTtc: product.prixTtc,
                              remisePercentage:
                                  product.supplier?.remises.isNotEmpty == true
                                  ? product
                                        .supplier!
                                        .remises
                                        .first
                                        .remisePercentage
                                  : 0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 8.h,
                              bottom: 10.h,
                              left: 10.w,
                              right: 10.w,
                            ),
                            child: ProductContainerButton(
                              colisage: product.colisage,
                              qat: product.quantity,
                              product: product,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 8.h,
                              horizontal: 40.w,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: SecondButton(
                              title: 'Produit Similaire',
                              height: 40.h,
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  proiduitSemailairPage,
                                  arguments: product.id,
                                );
                              },
                            ),
                          ),

                          Divider(
                            thickness: 1.5,
                            color: AppColors.second,
                            endIndent: MediaQuery.of(context).size.width / 3,
                          ),
                          Padding(
                            padding: EdgeInsetsGeometry.symmetric(
                              vertical: 5.h,
                            ),
                            child: Text(
                              "Informations",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF35343D),
                              ),
                            ),
                          ),
                          TabBarSection(
                            controller: tabController,
                            oemMakes: product.oemMakes,
                            applications: product.applications,
                          ),
                          SizedBox(height: 16.h),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
