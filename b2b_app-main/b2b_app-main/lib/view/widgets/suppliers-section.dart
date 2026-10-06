import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class SuppliersContainer extends StatefulWidget {
  final List<String> imagePaths;
  final String title;
  final String subtitle;
  final Color backgroundColor;

  const SuppliersContainer({
    super.key,
    required this.imagePaths,
    required this.title,
    required this.subtitle,
    this.backgroundColor = AppColors.secondBackground,
  });

  @override
  SuppliersContainerState createState() => SuppliersContainerState();
}

class SuppliersContainerState extends State<SuppliersContainer> {
  double offsetY = 0.0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification ||
            notification is ScrollUpdateNotification) {
          setState(() {
            offsetY = -20.h; // raise upward
          });
        } else if (notification is ScrollEndNotification) {
          setState(() {
            offsetY = 0; // reset back
          });
        }
        return true;
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, offsetY, 0),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 3.8,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: AppColors.second,
              thickness: 1.5,
              endIndent: MediaQuery.of(context).size.width / 2,
            ),
            Flexible(
              child: Text(
                widget.title,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
              child: Text(
                widget.subtitle,
                style: TextStyle(
                  color: AppColors.secondTextColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 45),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.imagePaths.map((imagePath) {
                  return Container(
                    margin: EdgeInsets.only(right: 10.w),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBackground,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.grey, width: 1.2.w),
                    ),
                    height: 100.h,
                    width: 100.w,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
