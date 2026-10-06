import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

class TextTitile extends StatelessWidget {
  final String title;
  final Color textColor;
  final FontWeight fontWeight;
  TextTitile({required this.title, 
  this.fontWeight = FontWeight.w400,
  this.textColor = AppColors.third});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 12, bottom: 5),
      child: Text(
        title,
        style: GoogleFonts.rubik(
            color: textColor, fontSize: 20, fontWeight: fontWeight),
      ),
    );
  }
}
