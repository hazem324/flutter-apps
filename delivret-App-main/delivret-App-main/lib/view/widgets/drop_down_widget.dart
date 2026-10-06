import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../utils/app_colors.dart';

class DropDownButtonWidget extends StatefulWidget {
  @override
  DropDownButtonState createState() => DropDownButtonState();

  final double width;
  final double height;
  final String hintText;
  final double hitTextSize;
  final Color? hitTextColor;
  final List<String> items;
  final String? selectedValue;
  final void Function(String?)? itemSelect;

  DropDownButtonWidget({
    super.key,
    this.height = 50,
    this.width = 360,
    required this.selectedValue,
    required this.hintText,
    required this.items,
    required this.itemSelect,
    this.hitTextColor = AppColors.greyColor,
    this.hitTextSize = 18,
  });
}

class DropDownButtonState extends State<DropDownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            Icon(
              Icons.list,
              size: 16,
              color: widget.hitTextColor,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                widget.hintText,
                style: TextStyle(
                  color: widget.hitTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: widget.hitTextSize,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: widget.selectedValue,
        onChanged: widget.itemSelect,

        /* (String? value) {
          setState(() {
            selectedValue = value;
          });
        },*/
        buttonStyleData: ButtonStyleData(
          height: widget.height,
          width: widget.width,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary,
            ),
            color: AppColors.white,
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down_rounded,
          ),
          iconSize: 24,
          iconEnabledColor: AppColors.primary,
          iconDisabledColor: AppColors.primary,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 350,
           padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.white,
          ),
          offset: const Offset(0, 0),
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all<Color>(AppColors.primary),
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(3),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
