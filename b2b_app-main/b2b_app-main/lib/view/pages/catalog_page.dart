import 'package:b2b_app/controller/cart_controller.dart';
import 'package:b2b_app/utils/app_colors.dart';
import 'package:b2b_app/view/widgets/product_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/makes_controller.dart';
import '../../controller/product_controller.dart';
import '../../controller/supplier_controller.dart';
import '../../utils/page_routes.dart';
import '../widgets/bottom_sheet_filter_container.dart';
import '../widgets/circular_progressindicator.dart';
import '../widgets/text_filed.dart';
import '../../utils/data.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  CatalogPageState createState() => CatalogPageState();
}

class CatalogPageState extends State<CatalogPage> {
  TextEditingController search = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final SupplierController supplierController = Get.put(SupplierController());
  final MakesController makesController = Get.put(MakesController());
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());
  int currentPage = 1;
  Map<String, bool> selectedSupplier = {};

  @override
  void initState() {
    super.initState();
    supplierController.getSuppliers();
    makesController.getMakes();
    productController.getAllProducts();
    //productController.getStockData();
    supplierController.getSuppliers().then((_) {
      setState(() {
        selectedSupplier = {
          for (var s in supplierController.suppliers) s.name: false,
        };
      });
    });

    scrollController.addListener(loadMoreProducts);

    cartController.getCart();
  }

  RangeValues currentRangeValues = const RangeValues(0, 2000);
  final Map<String, bool> selectedMarques = {
    for (var m in marquesList) m: false,
  };


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void loadMoreProducts() async {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !productController.isLoading.value) {
      setState(() {
        currentPage++;
      });
      await productController.getAllProducts(
        page: currentPage,
        pageSize: 10,
        order: "DESC",
        keyword: search.text.trim().isEmpty ? null : search.text.trim(),
        minPrice: currentRangeValues.start,
        maxPrice: currentRangeValues.end,
        makes: selectedMarques.entries
            .where((e) => e.value)
            .map((e) => e.key)
            .toList(),
        suppliers: selectedSupplier.entries
            .where((e) => e.value)
            .map((e) => e.key)
            .toList(),
        append: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
            decoration: BoxDecoration(
              color: AppColors.secondBackground,
              borderRadius: BorderRadius.circular(15),
            ),
            width: MediaQuery.of(context).size.width,
            height: 45.h,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomTextFiled(
                    icon: Icons.search,
                    hintText: 'Search...',
                    controller: search,
                    onSubmitted: (value) async {
                      final selectedMarqueList = selectedMarques.entries
                          .where((entry) => entry.value)
                          .map((entry) => entry.key)
                          .toList();

                      final selectedFournisseurList = selectedSupplier.entries
                          .where((entry) => entry.value)
                          .map((entry) => entry.key)
                          .toList();

                      setState(() {
                        currentPage = 1; // Reset page for new search
                      });

                      await productController.getAllProducts(
                        keyword: value.trim(),
                        minPrice: currentRangeValues.start,
                        maxPrice: currentRangeValues.end,
                        makes: selectedMarqueList,
                        suppliers: selectedFournisseurList,
                        isFilterRequest: true,
                      );
                    },
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    search.clear();

                    final selectedMarqueList = selectedMarques.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();

                    final selectedFournisseurList = selectedSupplier.entries
                        .where((entry) => entry.value)
                        .map((entry) => entry.key)
                        .toList();

                    setState(() {
                      currentPage = 1;
                    });

                    await productController.getAllProducts(
                      keyword: null,
                      minPrice: currentRangeValues.start,
                      maxPrice: currentRangeValues.end,
                      makes: selectedMarqueList,
                      suppliers: selectedFournisseurList,
                      isFilterRequest: true,
                    );
                  },
                  icon: Icon(Icons.close, color: AppColors.primary, size: 22.h),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet<Map<String, dynamic>>(
                      context: context,
                      isScrollControlled: true,
                      isDismissible: false,
                      enableDrag: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(18),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return BottomSheetFilterContainer(
                          supplierController: supplierController,
                          makesController: makesController,
                          initialRangeValues: currentRangeValues,
                          initialMarques: selectedMarques,
                          initialSupplier: selectedSupplier,
                          
                          onApplyFilters: (filters) async {
                            setState(() {
                              currentRangeValues = filters['rangeValues'];
                              selectedMarques.clear();
                              selectedMarques.addAll(filters['marques']);
                              selectedSupplier.clear();
                              selectedSupplier.addAll(filters['fournisseurs']);
                              currentPage = 1;
                            });

                            final selectedMarqueList = selectedMarques.entries
                                .where((entry) => entry.value)
                                .map((entry) => entry.key)
                                .toList();

                            final selectedFournisseurList = selectedSupplier
                                .entries
                                .where((entry) => entry.value)
                                .map((entry) => entry.key)
                                .toList();

                            await productController.getAllProducts(
                              minPrice: currentRangeValues.start,
                              maxPrice: currentRangeValues.end,
                              makes: selectedMarqueList,
                              suppliers: selectedFournisseurList,
                              keyword: search.text.trim().isEmpty
                                  ? null
                                  : search.text.trim(),
                              isFilterRequest: true,
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: AppColors.primary,
                    size: 22.h,
                  ),
                ),
              ],
            ),
          ),

          // Top container with filter chips (unchanged)
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
            decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.circular(10.h),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: _buildFilterChips()),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 7.w),
                  child: Obx(
                    () => Text(
                      "${productController.products.length} résultats compatibles",
                      style: TextStyle(
                        color: AppColors.third,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.5,
            color: AppColors.second,
            endIndent: MediaQuery.of(context).size.width / 3,
          ),

          Expanded(
            child: Container(
              color: AppColors.secondBackground,
              child: Obx(() {
                
                if (productController.isFiltering.value) {
                  return Center(
                    child: CustomCircularIndicator(),
                  );
                } else if (productController.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Text(
                      productController.errorMessage.value,
                      style: TextStyle(color: AppColors.third, fontSize: 16.sp),
                    ),
                  );
                } else if (productController.products.isEmpty) {
                  
                  if (productController.isLoading.value) {
                    return Center(
                      child: CustomCircularIndicator(),
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No products found",
                        style: TextStyle(color: AppColors.third, fontSize: 16.sp),
                      ),
                    );
                  }
                } else {
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: productController.products.length +
                        (productController.isLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == productController.products.length &&
                          productController.isLoading.value) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CustomCircularIndicator(),
                          ),
                        );
                      }
                      final product = productController.products[index];
                      return Column(
                        children: [
                          ProductContainer(
                            product: product,
                            onDetailTap: (productId) {
                              Navigator.pushNamed(
                                context,
                                detailProduitPage,
                                arguments: productId,
                              );
                            },
                            onRelatedTap: ({
                              required String desig,
                              required String productId,
                            }) {
                              Navigator.pushNamed(
                                context,
                                proiduitSemailairPage,
                                arguments: {
                                  'productId': productId,
                                  'desig': desig,
                                },
                              );
                            },
                          ),
                          SizedBox(height: 10.h),
                        ],
                      );
                    },
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFilterChips() {
    List<Widget> chips = [];

    if (currentRangeValues.start != 0 || currentRangeValues.end != 2000) {
      chips.add(
        _buildChip(
          'Prix: ${currentRangeValues.start.round()} DNT - ${currentRangeValues.end.round()} DNT',
        ),
      );
    }

    selectedMarques.forEach((marque, isSelected) {
      if (isSelected) {
        chips.add(_buildChip(marque));
      }
    });

    selectedSupplier.forEach((fournisseur, isSelected) {
      if (isSelected) {
        chips.add(_buildChip(fournisseur));
      }
    });

    return chips.isEmpty ? [const Text('Aucun filtre appliqué')] : chips;
  }

  Widget _buildChip(String label) {
    return Container(
      margin: EdgeInsets.only(right: 8.w),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label),
    );
  }
}