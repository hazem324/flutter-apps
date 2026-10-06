import 'package:deliveryapp/view/widgets/text_subtitle_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';

class ProfileContainer extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const ProfileContainer({super.key, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: TextSubTitile(subTitle: title!,),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin:const EdgeInsets.only(left: 20),
          padding:const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 5),
          height: 50,
          width: 350,
          decoration: BoxDecoration(
              borderRadius:const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                style: BorderStyle.solid,
                color: AppColors.primary,
                width: 1.2,
              )),
          child: Text(subtitle!, style: GoogleFonts.muktaVaani(fontSize: 17, fontWeight: FontWeight.w500),),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
