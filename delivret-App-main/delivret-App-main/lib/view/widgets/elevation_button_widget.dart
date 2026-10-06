import 'package:deliveryapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonElevationWidget extends StatelessWidget {
  final double width;
  final double height;
  final String titel;
  final Function onPressed;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;

  ButtonElevationWidget(
      {required this.titel,
      required this.onPressed,
      this.height = 50,
      this.width = 150,
      this.backgroundColor = AppColors.white,
      this.textColor = AppColors.primary,
      this.borderColor = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
        fixedSize:  Size(width, height),
        backgroundColor: backgroundColor,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.height / 53.6),
          side: BorderSide(width: size.width / 330.833, color: borderColor),
        ),
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.only(
              left: size.width / 33.08,
              right: size.width / 33.08,
              top: size.height / 67,
              bottom: size.height / 67),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(size.height / 53.6)),
          ),
          child: Center(
            child: Text(
              titel,
              style: TextStyle(
                  fontSize: 18, color: textColor, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
