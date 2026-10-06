import 'package:flutter/material.dart';

class AnimatedContainerWidget extends StatefulWidget {
  final String detarturAddress;
  final String livraisonAddress;
  final String status;
  final String fullName;
  final String phoneNumber;
  final int index;
  final Widget Function(BuildContext context, AnimatedContainerWidget widget)
      containerBuilder;

  AnimatedContainerWidget({
    required this.detarturAddress,
    required this.livraisonAddress,
    required this.status,
    this.fullName = '',
    this.phoneNumber = '',
    required this.index,
    required this.containerBuilder,
  });

  @override
  AnimatedContainerWidgetState createState() => AnimatedContainerWidgetState();
}

class AnimatedContainerWidgetState extends State<AnimatedContainerWidget> {
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300 + (widget.index * 200)),
      transform: Matrix4.translationValues(
          startAnimation ? 0 : MediaQuery.of(context).size.width, 0, 0),
      curve: Curves.fastOutSlowIn,
      child: widget.containerBuilder(context, widget),
    );
  }
}
