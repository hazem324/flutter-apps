import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotoSansText extends StatelessWidget {
  final String text;
  final Color colors;
  final double size;
  final FontWeight fontWeight;

  NotoSansText({required this.text, 
  required this.size,
    this.colors = Colors.black,
    this.fontWeight = FontWeight.bold
    });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: GoogleFonts.notoSans(
                color: colors, fontWeight: fontWeight, fontSize: size),
          ),
        ),
      ],
    );
  }
}
