import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';

class OrderTile extends StatelessWidget {
  final Map<String, String> commande;
  final VoidCallback onTap;

  const OrderTile({
    Key? key,
    required this.commande,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.primaryBackground,
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: 'N° commande : ',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 15.h,
                  fontWeight: FontWeight.w400,
                  wordSpacing: 1.2.w,
                ),
                children: [
                  TextSpan(
                    text: commande["num"],
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.1.w,
                      fontSize: 14.h,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),
            RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: 'Date : ',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 15.h,
                  fontWeight: FontWeight.w400,
                  wordSpacing: 1.2.w,
                ),
                children: [
                  TextSpan(
                    text: "${commande["date"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.1.w,
                      fontSize: 14.h,
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: 'Total : ',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 15.h,
                  fontWeight: FontWeight.w400,
                  wordSpacing: 1.2.w,
                ),
                children: [
                  TextSpan(
                    text: commande["total"],
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.1.w,
                      fontSize: 14.h,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: 'Statut : ',
                style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 15.h,
                  fontWeight: FontWeight.w400,
                  wordSpacing: 1.2.w,
                ),
                children: [
                  TextSpan(
  text: () {
    switch (commande["status"]) {
      case "PENDING":
        return "En attente";
      case "CONFIRMED":
        return "Confirmé";
      case "DELIVERED":
      case "LIVREE":
        return "Livrée";
      default:
        return commande["status"];
    }
  }(),
  style: TextStyle(
    fontWeight: FontWeight.w500,
    letterSpacing: 1.1.w,
    fontSize: 14.h,
    color: () {
      switch (commande["status"]) {
        case "DELIVERED":
        case "LIVREE":
          return AppColors.green;
        case "PENDING":
          return Colors.orange[700];
        case "CONFIRMED":
          return Colors.blue; // ou une autre couleur que tu préfères
        default:
          return Colors.grey;
      }
    }(),
  ),
),
                ],
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 20.w),
          onPressed: onTap,
        ),
      ),
    );
  }
}
