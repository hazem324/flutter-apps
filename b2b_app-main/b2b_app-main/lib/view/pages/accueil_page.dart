import 'package:b2b_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../utils/data.dart';
import '../widgets/container_image.dart';
import '../widgets/suppliers-section.dart';

class AcceuilPage extends StatelessWidget {


  final Function(int)? onNavigateToPage;
  const AcceuilPage({super.key, this.onNavigateToPage});
  @override
  Widget build(BuildContext context) {
    return 
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ContainerImage(onNavigateToPage: onNavigateToPage),
              SuppliersContainer(
                imagePaths: supplierImagePaths,
                title: "Nos fournisseurs des pièces",
                subtitle:
                    "Grandes offres de pièces de voiture des meilleurs fabricants.",
              ),

              SuppliersContainer(
                imagePaths: brandImagePaths,
                title: "Nos marques automobile",
                subtitle:
                    "Toutes vos pièces auto, pour toutes les grandes marques.",
                backgroundColor: AppColors.primaryBackground,
              ),
              SizedBox(height: MediaQuery.of(context).size.height/45,)

            ],
          ),
        ),

    );
  }
}
