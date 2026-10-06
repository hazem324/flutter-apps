import 'package:b2b_app/utils/app_colors.dart';
import 'package:b2b_app/view/widgets/secondButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class ContainerImage extends StatelessWidget {
   final Function(int)? onNavigateToPage; 

  const ContainerImage({super.key, this.onNavigateToPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.h),
          bottomRight: Radius.circular(20.h),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/acceuil.png", fit: BoxFit.cover),      
          Container(
            color: Colors.black.withAlpha(170),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              SizedBox(height: MediaQuery.of(context).size.height / 75),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Votre partenaire pour toutes vos ',
                    style: TextStyle(
                      color: AppColors.primaryBackground,
                      fontSize: 18.h,
                      fontWeight: FontWeight.w900,
                      wordSpacing: 1.2.w,
                      height: 1.1.h,
                    ),
                    children: [
                      TextSpan(
                        text: 'pièces automobiles.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.1.h,
                          wordSpacing: 1.2.w,
                          fontSize: 22.h,
                          color: AppColors.primaryBackground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 45),
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text:
                        'Trouvez la pièce auto qu’il vous faut, en quelques clics,\n ',
                    style: TextStyle(
                      color: AppColors.primaryBackground,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      wordSpacing: 1.15.w,
                      height: 1.1.h,
                    ),
                    children: [
                      TextSpan(
                        text:
                            'Des pièces de qualité, pour toutes les marques et modèles.',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          height: 1.1.h,
                          wordSpacing: 1.15.w,
                          fontSize: 17.sp,
                          color: AppColors.primaryBackground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

               Center(
                 child: SecondButton(
                  width: MediaQuery.of(context).size.width/1.2,
                  backgroundColor: Colors.transparent,
                  textColor: AppColors.primaryBackground,
                  title: "decouvrire notre produit", onPressed: () {
      print('SecondButton pressed in ContainerImage');
      if (onNavigateToPage == null) {
        print('onNavigateToPage is null');
      } else {
        print('Calling onNavigateToPage with index 1');
        onNavigateToPage?.call(1);
      }
    },),
               )
            ],
          ),
        ],
      ),
    );
  }
}