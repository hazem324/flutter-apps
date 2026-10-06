import 'dart:io';

import 'package:deliveryapp/controller/user_controller.dart';
import 'package:deliveryapp/utils/const_string.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/app_colors.dart';
import 'custom_tost_widget.dart';
import 'text_subtitle_widget.dart';
import 'text_title_widget.dart';

class ProfileImage extends StatefulWidget {
  final String? imageUrl;
  ProfileImage({required this.imageUrl});

  @override
  ProfileImageState createState() => ProfileImageState();
}

class ProfileImageState extends State<ProfileImage> {
  File? image;
  UserController userController = Get.put(UserController());

  final tost = FToast();

  @override
  void initState() {
    super.initState();

    tost.init(context);
  }

  @override
  Widget build(BuildContext context) {
    print('image ++++++++++ ${widget.imageUrl.toString()}');
    final double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => showChoiceDialog(),
      child: CircleAvatar(
        radius: screenHeight / 11.48,
        backgroundImage: (widget.imageUrl == 'null' || widget.imageUrl.toString().isEmpty )
            ? const AssetImage("assets/images/userProfile.png")
            : NetworkImage("$ServerUrl${widget.imageUrl}") as ImageProvider<Object>,
      ),
    );
  }

  Future<void> showChoiceDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          final double screenHeight = MediaQuery.of(context).size.height;
          return AlertDialog(
            title: TextTitile(
              title: translation(context).photo_obti,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(height: 1, color: Colors.grey),
                  ListTile(
                    onTap: () => pickImage(ImageSource.gallery),
                    title: TextSubTitile(subTitle: translation(context).gallery),
                    leading: Icon(
                      Icons.photo_album,
                      color: AppColors.primary,
                      size: screenHeight / 32.11,
                    ),
                  ),
                  const Divider(height: 1, color: Colors.grey),
                  ListTile(
                    onTap: () => pickImage(ImageSource.camera),
                    title: TextSubTitile(subTitle: translation(context).camera),
                    leading: Icon(
                      Icons.camera,
                      color: AppColors.primary,
                      size: screenHeight / 32.11,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      print('image: $image');
      setState(() {
        this.image = imageTemporary;
      });

      print('image file path: ${imageTemporary.path}');

      final msg = await userController.uploadImage(imageTemporary.path);
      tost.showToast(
          child: CustomTostWidget(text: msg ?? ""),
          gravity: ToastGravity.BOTTOM);
    } catch (e) {
      print("Failed to pick image: $e");
    }
  }
}
