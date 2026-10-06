import 'dart:convert';

import 'package:b2b_app/utils/app_colors.dart';
import 'package:b2b_app/utils/page_routes.dart';
import 'package:b2b_app/view/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/labeled_text_field.dart';
import '../../models/client_model.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  ProfilPageState createState() => ProfilPageState();
}

class ProfilPageState extends State<ProfilPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController matriculeFiscaleController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  ClientModel? client;

  @override
  void initState() {
    super.initState();
    loadClientData();
  }

  Future<void> loadClientData() async {
    final prefs = await SharedPreferences.getInstance();
    final clientJson = prefs.getString('client_data');

    if (clientJson != null) {
      final decoded = jsonDecode(clientJson);
      client = ClientModel.fromJson(decoded);

      setState(() {
        usernameController.text = client!.username;
        fullNameController.text = client!.fullName;
        phoneController.text = client!.phoneNumber;

        addressController.text = client!.address;
        cityController.text = client!.city;
        governorateController.text = client!.governorate;
        roleController.text = client!.role;
      });
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    governorateController.dispose();
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 70.r,
                      backgroundImage: const AssetImage(
                        'assets/images/avatar.png',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        client?.fullName ?? "Chargement...",
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 25),

                // Champs utilisateur avec titres
                Column(
                  children: [
                    buildLabeledField(
                      label: "Nom d'utilisateur",
                      icon: FontAwesomeIcons.user,
                      controller: usernameController,
                    ),
                    buildLabeledField(
                      label: "Nom complet",
                      icon: Icons.person,
                      controller: fullNameController,
                    ),
                    buildLabeledField(
                      label: "Téléphone",
                      icon: Icons.phone,
                      controller: phoneController,
                    ),
                    buildLabeledField(
                      label: "Adresse",
                      icon: Icons.location_on,
                      controller: addressController,
                    ),
                    buildLabeledField(
                      label: "Ville",
                      icon: Icons.location_city,
                      controller: cityController,
                    ),
                    buildLabeledField(
                      label: "Gouvernorat",
                      icon: Icons.map,
                      controller: governorateController,
                    ),
                    // buildLabeledField(
                    //   label: "Rôle",
                    //   icon: Icons.work,
                    //   controller: roleController,
                    // ),
                    SizedBox(height: 20.h),

                    PrimaryButton(
                      title: "Modifier le profil",
                      onPressed: () async {},
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 43.h,
                    ),
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height / 40),

                // Bouton de déconnexion
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 43.h,
                  child: OutlinedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        loginPage,
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                      side: BorderSide(color: AppColors.second),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      backgroundColor: AppColors.primaryBackground,
                    ),
                    child: Text(
                      "Se déconnecter",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.second,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
