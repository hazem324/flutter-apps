import 'package:deliveryapp/utils/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_colors.dart';
import 'text_subtitle_widget.dart';
import 'text_title_widget.dart';

class LivreurOrderContainerWidget extends StatefulWidget {
  @override
  LivreurOrderContainerWidgetState createState() => LivreurOrderContainerWidgetState();

  final String detarturAddress;
  final String livraisonAddress;
  final String status;
  final String fullName;
  final String phoneNumber;
  final int index;
 
  LivreurOrderContainerWidget({
    required this.detarturAddress,
    required this.livraisonAddress,
    required this.fullName,
    required this.phoneNumber,
    required this.status,
    required this.index,
   
  });
}

class LivreurOrderContainerWidgetState extends State<LivreurOrderContainerWidget> {
  bool addButton = false;
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
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(bottom: 5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: AppColors.containerColor,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0.5, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextTitile(
              title: "Order N° ${widget.index}: ",
              fontWeight: FontWeight.w700,
            ),
            TextSubTitile(
              subTitle: ' - ${translation(context).departure_address}',
              fontWeight: FontWeight.w500,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                widget.detarturAddress,
                style: GoogleFonts.inconsolata(fontSize: 18),
              ),
            ),
            TextSubTitile(
              subTitle: '- ${translation(context).livraison_address}',
              fontWeight: FontWeight.w500,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                widget.livraisonAddress,
                style: GoogleFonts.inconsolata(fontSize: 18),
              ),
            ),
            Row(
              children: [
                TextSubTitile(
                  subTitle: '- ${translation(context).status} :',
                  fontWeight: FontWeight.w500,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(widget.status,
                      style: GoogleFonts.merriweather(
                        fontSize: 15,
                      )),
                ),
              ],
            ),
            Row(
              children: [
                TextSubTitile(
                  subTitle: '- ${translation(context).client_fullName}',
                  fontWeight: FontWeight.w500,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(widget.fullName,
                      style: GoogleFonts.merriweather(
                        fontSize: 15,
                      )),
                ),
              ],
            ),
            Row(children: [
              TextSubTitile(
              subTitle: '- ${translation(context).phone_number}',
              fontWeight: FontWeight.w500,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(widget.phoneNumber,
                  style: GoogleFonts.merriweather(
                    fontSize: 15,
                  )),
            ),
            ],)
            
          ],
        ),
      ),
    );
  }
}
