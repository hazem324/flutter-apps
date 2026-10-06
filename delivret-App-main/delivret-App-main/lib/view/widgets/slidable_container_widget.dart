import 'package:deliveryapp/utils/app_colors.dart';
import 'package:deliveryapp/utils/language_constant.dart';
import 'package:deliveryapp/view/widgets/text_title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'animated_container_widget.dart';
import 'text_subtitle_widget.dart';

class SlidableContainer extends StatelessWidget {
  final String detarturAddress;
  final String livraisonAddress;
  final String status;
  final int index;
  final bool startAnimation;
  final void Function() onDelete;
  final void Function() onUpdate;
  SlidableContainer(
      {required this.index,
      required this.detarturAddress,
      required this.livraisonAddress,
      required this.status,
      required this.onDelete,
      required this.startAnimation,
      required this.onUpdate});
  @override
  Widget build(BuildContext context) {
    return Slidable(
        startActionPane: ActionPane(
          key: ValueKey(index),
          motion: const ScrollMotion(),
          // dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) => onDelete(),
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: translation(context).delete,
              borderRadius: BorderRadius.circular(20),
            ),
            SlidableAction(
              onPressed: (context) => onUpdate(),
              backgroundColor: AppColors.second,
              foregroundColor: Colors.white,
              icon: Icons.edit_document,
              label: translation(context).update,
              borderRadius: BorderRadius.circular(20),
            ),
          ],
        ),
        child: AnimatedContainerWidget(
          detarturAddress: detarturAddress,
          livraisonAddress: livraisonAddress,
          status: status,
          index: index,
        
          containerBuilder:
              (BuildContext context, AnimatedContainerWidget widget) {
            return Container(
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
                      offset: Offset(2, 0),
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
                      padding: const EdgeInsets.only(left: 40),
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
                      padding: const EdgeInsets.only(left: 40),
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
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(widget.status,
                              style: GoogleFonts.merriweather(
                                fontSize: 15,
                              )),
                        ),
                      ],
                    ),
                  ],
                ));
          },
        ));
  }
}
