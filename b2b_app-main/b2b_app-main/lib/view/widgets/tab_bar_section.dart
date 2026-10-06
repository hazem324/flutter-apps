import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/application_model.dart';
import '../../models/oam_make_model.dart';
import '../../utils/app_colors.dart';

class TabBarSection extends StatelessWidget {
  final TabController controller;
  final List<OemMakeModel> oemMakes;
  final List<ApplicationModel> applications;

  const TabBarSection({
    super.key,
    required this.controller,
    required this.oemMakes,
    required this.applications,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.h),
    height: MediaQuery.of(context).size.height / 4,
    width: MediaQuery.of(context).size.width,
    child: Column(
      children: [
        TabBar(
          controller: controller,
          overlayColor: WidgetStateProperty.all(AppColors.secondBackground),
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.secondTextColor,
          labelStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          unselectedLabelStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          indicatorColor: AppColors.primary,
          indicatorWeight: 2,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          tabs: const [
            Tab(text: "Références origine"),
            Tab(text: "Véhicules compatibles"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              // Tab 1: OEM Makes
              oemMakes.isEmpty
                  ? Center(
                      child: Text(
                        "Aucune référence d'origine",
                        style: TextStyle(color: AppColors.secondTextColor),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: oemMakes.length,
                      itemBuilder: (context, index) {
                        final oem = oemMakes[index];
                        return ListTile(
                          leading: const Icon(Icons.settings),
                          title: Text(oem.oem),
                        );
                      },
                    ),

              // Tab 2: Applications
              applications.isEmpty
                  ? Center(
                      child: Text(
                        "Aucun véhicule compatible",
                        style: TextStyle(color: AppColors.secondTextColor),
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      children: _buildApplicationTiles(),
                    ),
            ],
          ),
        ),
      ],
    ),
  );
  }

 List<Widget> _buildApplicationTiles() {
  if (applications.isEmpty) {
    return []; 
  }

 
  final Map<String, List<ApplicationModel>> grouped = {};

  for (final app in applications) {
    final make =(app.make.name.isNotEmpty) ? app.make.name : "Marque inconnue";
    final model =(app.model.name.isEmpty) ? app.model.name : "Tous les modèles";
    final key = "$make - $model";
      
    grouped.putIfAbsent(key, () => []).add(app);
  }

  return grouped.entries.map((entry) {
    final title = entry.key;
    final versions = entry.value;

    return ExpansionTile(
      iconColor: AppColors.primary,
      title: Text(title, style: TextStyle(fontSize: 14.sp)),
      children: versions.map((app) {
        final version =(app.version.name.isNotEmpty)? app.version.name  : "Toutes les versions";
        
        return ListTile(
          leading: const Icon(Icons.directions_car),
          title: Text(version),
        );
      }).toList(),
    );
  }).toList();
}
}
