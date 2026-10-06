import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StepperWidget extends StatefulWidget {
  final int status;
  StepperWidget({required this.status});
  @override
  StepperWidgetState createState() => StepperWidgetState();
}

class StepperWidgetState extends State<StepperWidget> {
  int activeStep = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      activeStep = widget.status;
    });
    
   
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: EasyStepper(
          direction: Axis.vertical,
          activeStep: activeStep,
          stepAnimationCurve: Curves.decelerate,
          lineStyle: const LineStyle(
            lineLength: 50,
            lineWidth: 10,
            lineThickness: 3,
            lineType: LineType.normal,
            finishedLineColor: Colors.green,
            unreachedLineColor: Colors.grey,
            activeLineColor: Colors.grey,
          ),
          activeStepBorderColor: Colors.green,
          activeStepIconColor: Colors.black,
          activeStepTextColor: Colors.green,
           activeStepBackgroundColor:(activeStep == 3 )? Colors.green: Colors.white,
          
         /* unreachedStepBackgroundColor: Colors.grey,
          unreachedStepBorderColor: Colors.blueGrey,
          unreachedStepIconColor: Colors.blueGrey,
          unreachedStepTextColor: Colors.blueGrey,*/
          finishedStepBackgroundColor: Colors.green,
          finishedStepBorderColor: Colors.green,
          finishedStepIconColor: Colors.black,
          finishedStepTextColor: Colors.black,
          borderThickness: 2,
          internalPadding: 20,
          showStepBorder: true,
          showLoadingAnimation: activeStep != widget.status,
          stepRadius: 35,
          showTitle: true,
          steps: [
            EasyStep(
              customStep: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Opacity(
                  opacity: activeStep >= 0 ? 1 : 0.3,
                  child:const Icon(Icons.hourglass_top_outlined, color: Colors.black, weight: 8, size: 26),
                ),
              ),
              customTitle: Text(
                'Processing',
                style:
                    GoogleFonts.arvo(fontWeight: FontWeight.w600, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            EasyStep(
              customStep: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Opacity(
                  opacity: activeStep >= 1 ? 1 : 0.3,
                  child: const  Icon(Icons.touch_app_outlined,  color: Colors.black, weight: 8, size: 26),
                ),
              ),
              customTitle: Text(
                'Packaging',
                style:
                    GoogleFonts.arvo(fontWeight: FontWeight.w600, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            EasyStep(
              customStep: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Opacity(
                  opacity: activeStep >= 2 ? 1 : 0.3,
                  child: const Icon(Icons.local_shipping_outlined ,  color: Colors.black, weight: 8, size: 26),
                ),
              ),
              customTitle: Text(
                'inTransit',
                style:
                    GoogleFonts.arvo(fontWeight: FontWeight.w600, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
            EasyStep(
              customStep: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Opacity(
                  opacity: activeStep >= 3 ? 1 : 0.3,
                  child: const Icon(Icons.task_alt_outlined,  color: Colors.black, weight: 8, size: 26),
                ),
              ),
              customTitle: Text(
                'Delivered',
                style:
                    GoogleFonts.arvo(fontWeight: FontWeight.w600, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            )
          ]),
    );
  }
}
