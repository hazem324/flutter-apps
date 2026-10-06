import 'package:b2b_app/models/application_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductContainerMakes extends StatelessWidget {
  final List<ApplicationModel> applications;
  final double height; 
  final double width;
  const ProductContainerMakes({super.key, required this.applications, this.height = 45, this.width = 45});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: applications.map((app) {
          final brandName = app.make.name.toLowerCase();
          final imagePath = 'assets/images/makes/$brandName.png';

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            child: Image.asset(
              imagePath,
              width: width.w,
              height: height.w,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/images/image_not_found.jpg", width: 30.w, height: 30.h,);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
