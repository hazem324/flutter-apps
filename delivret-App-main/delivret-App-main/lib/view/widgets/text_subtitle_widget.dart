import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSubTitile extends StatelessWidget {
  final String subTitle;
  final Color textColor;
  final FontWeight fontWeight;
  final double fontSize;
 
  TextSubTitile(
      {required this.subTitle,
      this.fontWeight = FontWeight.w300,
      this.textColor = Colors.black,
      this.fontSize = 18});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const  EdgeInsets.only(top: 0, left: 8, bottom: 5),
      child: Text(
        subTitle,
         maxLines: null, // This allows the text to wrap automatically
                  overflow: TextOverflow.visible,
        style: GoogleFonts.montserrat(
            color: textColor, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
