import 'package:deliveryapp/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PassWordField extends StatefulWidget {
  @override
  PassWordFieldState createState() => PassWordFieldState();

  final controller;
  final String hintText;
 // final bool obscureText;
  final Icon icon;
  final Color iconColor;
  final double top;
  final double buttom;
  final double left;
  final double right;
  PassWordField({
    super.key,
   // this.obscureText = false,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.iconColor,
    this.top = 0,
    this.buttom = 0,
    this.left = 0,
    this.right = 0,
  });
}

class PassWordFieldState extends State<PassWordField> {
bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: 350,
      child: Padding(
        padding:
            EdgeInsets.only(top: widget.top, bottom: widget.buttom, left: widget.left, right: widget.right),
        child: TextField(
          obscuringCharacter: "*",
          controller: widget.controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              suffixIcon: IconButton(
                icon:obscureText
                    ? Icon(Icons.visibility_off, color: widget.iconColor)
                    : Icon(Icons.visibility, color: widget.iconColor),
                onPressed: () {
                  setState(() {
              obscureText =! obscureText;
            });
                },
              ),
              prefixIcon: Icon(
                widget.icon.icon,
                color: widget.iconColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(size.height / 32.16)),
                borderSide:
                    const BorderSide(color: AppColors.second, width: 1.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(size.height / 32.16)),
                borderSide:
                    const BorderSide(color: AppColors.second, width: 1.5),
              ),
              fillColor: AppColors.white,
              filled: true,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 18)),
        ),
      ),
    );
  }
}
