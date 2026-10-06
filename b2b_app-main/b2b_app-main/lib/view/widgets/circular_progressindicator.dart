import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class CustomCircularIndicator extends StatelessWidget{
  const CustomCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: AppColors.primary,
    );
  }

  
}