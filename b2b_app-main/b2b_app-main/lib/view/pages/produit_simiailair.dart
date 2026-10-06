import 'package:b2b_app/utils/app_colors.dart';
import 'package:b2b_app/view/widgets/circular_progressindicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/product_controller.dart';
import '../../utils/page_routes.dart';
import '../widgets/product_container.dart';

class ProiduitSimiailair extends StatefulWidget{
const ProiduitSimiailair({super.key});

@override
  ProiduitSimiailairState createState()=> ProiduitSimiailairState();
}

class ProiduitSimiailairState extends State<ProiduitSimiailair>  {

  final ProductController productController = Get.put(ProductController());
  final ScrollController scrollController = ScrollController();
  int currentPage = 1;
  String? productId;
String? desig;
@override
  void initState(){
    super.initState();
   
   WidgetsBinding.instance.addPostFrameCallback((_) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      productId = args['productId'] as String?;
  desig = args['desig'] as String?;

    print("Received Product ID: $productId");
    productController.getRelatedPRoduct(id: productId ?? "");
    
    // Now that productId is available, register the listener
    scrollController.addListener(() => loadMoreProducts(productId ?? ""));
  });

  
}
  @override
  Widget build(BuildContext context) {
  final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

      final localDesig = args?['desig'] as String? ?? '';
  final localProductId = args?['productId'] as String? ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackground,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, size: 28.sp, color: AppColors.primary),
        ),
      ),
      backgroundColor: AppColors.secondBackground,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),

                decoration: BoxDecoration(
                  color: AppColors.secondBackground,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Produits Equivalents à: ",
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        height: 1.5,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            localDesig,
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w200,
                              fontSize: 15.sp,
                            ),
                          ),

                          SizedBox(width: 20), // spacing between items
                          Text(
                            localProductId,
                            style: TextStyle(
                              color: AppColors.secondTextColor,
                              fontWeight: FontWeight.w300,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                
                      Obx(()=>
                      Text(
                      "${productController.relatedProducts.length} résultats compatibles",
                      style: TextStyle(
                        color: AppColors.third,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),)
                
                  ],
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height / 85),
              Expanded(
                child: Obx(() {
    if (productController.isLoading.value) {
      return Center(child: CustomCircularIndicator());
    } else if (productController.relatedProducts.isEmpty) {
      return Center(child: Text("Aucun produit équivalent trouvé."));
    }

    return ListView.separated(
  controller: scrollController,
  itemCount: productController.relatedProducts.length,
  itemBuilder: (context, index) {
    final product = productController.relatedProducts[index];
    return ProductContainer(
      product: product,
      onDetailTap: (String productId) {
        Navigator.pushNamed(context, detailProduitPage, arguments: productId);
      },
      onRelatedTap: ({required String desig, required String productId}) {
      },
    );
  },
  separatorBuilder: (context, index) => SizedBox(height: 8.h),
);

  }),
),
           
            ],
          ),
        ),
      ),
    );
  }

 void loadMoreProducts(String productId) async {
    if (!productController.isLoading.value &&
        productController.hasNext.value &&
        scrollController.position.pixels >= scrollController.position.maxScrollExtent - 300) {
      
      print("Loading page: $currentPage");
      productController.isLoading.value = true;
      await productController.getRelatedPRoduct(id: productId, page: currentPage);
    }
  }
}
