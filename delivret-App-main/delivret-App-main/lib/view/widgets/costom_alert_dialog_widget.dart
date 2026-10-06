import 'package:deliveryapp/utils/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:deliveryapp/view/widgets/text_title_widget.dart';
import 'package:deliveryapp/utils/app_colors.dart';

import 'elevation_button_widget.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final String confirmButtonText;
  final VoidCallback onConfirmPressed;
  
  const CustomAlertDialog({
    required this.title,
    required this.content,
    required this.confirmButtonText,
    required this.onConfirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: Colors.white,
      title: TextTitile(title: title),
      content:  content,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ButtonElevationWidget(
              width: screenWidth/4.3,
              titel: translation(context).ok,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ButtonElevationWidget(
              width: screenWidth/4.3,
              textColor: AppColors.white,
              backgroundColor: AppColors.primary,
              titel: confirmButtonText,
              onPressed: onConfirmPressed,
            ),
          ],
        )
      ],
    );
  }
}
