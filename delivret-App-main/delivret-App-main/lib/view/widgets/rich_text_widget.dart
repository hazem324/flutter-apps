import 'package:deliveryapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Function function;

  TextWidget(
      {required this.firstText,
      required this.secondText,
      required this.function
      });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20,),
        GestureDetector(
          onTap: ()=>function(),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: firstText,
                  style:  const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.blackbar),
            ),
              TextSpan(text:secondText, style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary),),
            ]),
          ),
        ),
        
      ],
    );
  }
}
