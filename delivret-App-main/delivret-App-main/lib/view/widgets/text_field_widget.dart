import 'package:deliveryapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
   final TextInputType keyboardType;
  final Icon? icon;
  final Color? iconColor;
  final double hitTextSize;
  final Color? hitTextColor;
  final double top;
  final double buttom;
  final double left;
  final double right;
  final bool fixIconBool;
  final int maxline;
  final double height;
  final double? width;

  const MyTextField({
    super.key,
    this.maxline = 1,
    this.hitTextColor = AppColors.greyColor,
    this.hitTextSize = 18,
    required this.controller,
    required this.hintText,
    this.fixIconBool = true,
    this.iconColor,
    this.icon,
    this.top = 0,
    this.buttom = 0,
    this.left = 0,
    this.right = 0,
    this.height = 70,
    this.width = 300,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      // color: Colors.amber,
      width: 350,
      height: height,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(
              top: top, bottom: buttom, left: left, right: right),
          child: TextField(
              keyboardType: keyboardType,
              maxLines: maxline,
              controller: controller,
              textInputAction: TextInputAction.next,
              decoration: (fixIconBool == true)
                  ? InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      prefixIcon: Icon(
                        icon?.icon,
                        color: iconColor, // Use the provided icon color here
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.height / 32.16)),
                        borderSide: const BorderSide(
                            color: AppColors.second, width: 1.2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.height / 32.16)),
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 1.5),
                      ),
                      fillColor: AppColors.white,
                      filled: true,
                      hintText: hintText,
                      hintStyle: TextStyle(
                          color: hitTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: hitTextSize))
                  :
                  // no icon
                  InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.height / 32.16)),
                        borderSide: const BorderSide(
                            color: AppColors.second, width: 1.2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(size.height / 32.16)),
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 1.5),
                      ),
                      fillColor: AppColors.white,
                      filled: true,
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: hitTextColor,
                        fontWeight: FontWeight.w400,
                        fontSize: hitTextSize,
                      ))),
        ),
      ),
    );
  }
}
