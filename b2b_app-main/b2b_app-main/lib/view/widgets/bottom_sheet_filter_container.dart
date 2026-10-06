import 'package:b2b_app/view/widgets/circular_progressindicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/makes_controller.dart';
import '../../controller/supplier_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/data.dart';
import 'filter_expansion_tile.dart';

class BottomSheetFilterContainer extends StatefulWidget {
  final RangeValues initialRangeValues;
  final Map<String, bool> initialMarques;
  final Map<String, bool> initialSupplier;
  final Function(Map<String, dynamic>) onApplyFilters;

  final SupplierController supplierController;
  final MakesController makesController;

  const  BottomSheetFilterContainer({
    super.key,
    required this.initialRangeValues,
    required this.initialMarques,
    required this.initialSupplier,
    required this.onApplyFilters,
    required this.supplierController,
    required this.makesController,
  });

  @override
  BottomSheetFilterContainerState createState() =>
      BottomSheetFilterContainerState();
}

class BottomSheetFilterContainerState  extends State<BottomSheetFilterContainer> {
  late RangeValues currentRangeValues;
  late Map<String, bool> selectedMarques;
  late Map<String, bool> selectedSupplier;
  //late Map<String, bool> selectedDisponi;
   

  bool isMarqueTileExpanded = false;
  bool isFournisseurTileExpanded = false;
  bool isDisponibiliteExpanded = false;

  @override
  void initState() {
    super.initState();

    currentRangeValues = widget.initialRangeValues;
    selectedMarques = Map<String, bool>.from(widget.initialMarques);
    selectedSupplier = Map<String, bool>.from(widget.initialSupplier);

  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height:
          MediaQuery.of(context).size.height /
          (isDisponibiliteExpanded
              ? 2
              : (isMarqueTileExpanded || isFournisseurTileExpanded
                    ? 1.2
                    : 2.7)),
      padding:  EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.r),
          topRight: Radius.circular(18.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    currentRangeValues = const RangeValues(0, 2000);
                    selectedMarques.clear();
                    selectedMarques.addAll({
                      for (var m in marquesList) m: false,
                    });
                    selectedSupplier.clear();
                    selectedSupplier.addAll({
                      for (var s in widget.supplierController.suppliers)
                        s.name: false,
                    });
                    // selectedDisponi.clear();
                    // selectedDisponi.addAll({
                    //   for (var d in disponibiliteList) d: false,
                    // });
                    
                  });
                  widget.onApplyFilters({
                    'rangeValues': currentRangeValues,
                    'marques': selectedMarques,
                    'fournisseurs': selectedSupplier,
                    'disponi': null,
                  });
                },
                child: Text(
                  "Clear".toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              Text(
                "Filter par",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontSize: 19.sp,
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.onApplyFilters({
                    'rangeValues': currentRangeValues,
                    'marques': selectedMarques,
                    'fournisseurs': selectedSupplier,
                    
                  });
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: AppColors.secondLight,
                  size: 19.h,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          RangeSlider(
            activeColor: AppColors.primary,
            values: currentRangeValues,
            min: 0,
            max: 2000,
            labels: RangeLabels(
              '${currentRangeValues.start.round()} DNT',
              '${currentRangeValues.end.round()} DNT',
            ),
            onChanged: (RangeValues values) {
              setState(() {
                currentRangeValues = values;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${currentRangeValues.start.round()} DNT'),
              Text('${currentRangeValues.end.round()} DNT'),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Obx(() {
                  if (widget.makesController.isLoading.value) {
                    return  Center(
                      child: CustomCircularIndicator(),
                    );
                  }
                  if (widget.makesController.errorMessage.isNotEmpty) {
                    return Text(
                      widget.supplierController.errorMessage.value,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    );
                  }
                  if (widget.makesController.makes.isEmpty) {
                    return const Text("Aucun makes trouvé.");
                  }
                  return FilterExpansionTile(
                    title: "Filter par marque",
                    items: widget.makesController.makes
                        .map((m) => m.name)
                        .toList(),
                    selectedItems: selectedMarques,
                    onExpansionChanged: (expanded) {
                      setState(() {
                        isMarqueTileExpanded = expanded;
                      });
                    },
                    onSelectionChanged: (updatedSelections) {
                      setState(() {
                        selectedMarques.clear();
                        selectedMarques.addAll(updatedSelections);
                      });
                    },
                  );
                }),

                Obx(() {
                  if (widget.supplierController.isLoading.value) {
                    return  Center(
                      child: CustomCircularIndicator()
                    );
                  }

                  if (widget.supplierController.errorMessage.value.isNotEmpty) {
                    return Text(
                      widget.supplierController.errorMessage.value,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    );
                  }

                  if (widget.supplierController.suppliers.isEmpty) {
                    return const Text("Aucun fournisseur trouvé.");
                  }

//Filter par fournisseur
                  return FilterExpansionTile(
                    title: "Filter par fournisseur",
                    items: widget.supplierController.suppliers
                        .map((s) => s.name)
                        .toList(),
                    selectedItems: selectedSupplier,
                    onExpansionChanged: (expanded) {
                      setState(() {
                        isFournisseurTileExpanded = expanded;
                      });
                    },
                    onSelectionChanged: (updatedSelections) {
                      setState(() {
                        selectedSupplier.clear();
                        selectedSupplier.addAll(updatedSelections);
                      });
                    },
                  );
                }),
   
              ],
            ),
          ),
        ],
      ),
    );
  }
}
