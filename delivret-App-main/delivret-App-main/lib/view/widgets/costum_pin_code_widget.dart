import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomPinFiled extends StatelessWidget {
  final TextEditingController controller;

  CustomPinFiled({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        controller: controller,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(10),
            borderWidth: 2,
            fieldHeight: 60,
            fieldWidth: 60,
            selectedColor: Colors.green,
            activeColor: Colors.green,
            inactiveColor: Colors.grey),
      ),
    );
  }
}
