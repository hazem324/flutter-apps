import 'package:deliveryapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PlaceTypeContainer extends StatefulWidget {
  @override
  PlaceTypeContainerState createState() => PlaceTypeContainerState();

  final String imgPath;
  final String placeText;

  final Function(String) onSelect;
  const PlaceTypeContainer({super.key, 
    required this.imgPath,
    required this.placeText,
    required this.onSelect,
  });
}

class PlaceTypeContainerState extends State<PlaceTypeContainer> {
  bool isSelected = false;
  String selectedPlaceName = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        setState(() {
          isSelected = !isSelected;
          if (isSelected) {
            selectedPlaceName = widget.placeText;
          } else {
            selectedPlaceName = "";
          }
          if (selectedPlaceName.isNotEmpty) {
            selectedPlaceName = selectedPlaceName;
          }
          widget.onSelect(selectedPlaceName);
        }),
      },
      child: Container(
        margin: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
        height: 45,
        width: 110,
        decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              widget.imgPath,
              width: 80,
              height: 70,
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(widget.placeText),
            ),
          ],
        ),
      ),
    );
  }
}
