import 'package:flutter/material.dart';

class CustomPageTransition extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  CustomPageTransition({required this.child, this.direction = AxisDirection.right})
      : super(
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return child;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child)
                {
            Offset begin;
            switch (direction) {
              case AxisDirection.up:
                begin = const Offset(0, 1);
                break;
              case AxisDirection.down:
                begin = const Offset(0, -1);
                break;
              case AxisDirection.right:
                begin = const Offset(1, 0); // Adjusted for right direction
                break;
              case AxisDirection.left:
                begin = const Offset(-1, 0); // Adjusted for left direction
                break;
            } {
              return SlideTransition(
                position:
                    Tween<Offset>(
                      begin: begin, 
                    
                    end: Offset.zero)
                        .animate(animation),
                child: child,
              );
            }});
}
