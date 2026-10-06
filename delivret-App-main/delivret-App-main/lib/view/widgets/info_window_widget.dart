import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_colors.dart';
import 'elevation_button_widget.dart';
import 'notosans_text_widget.dart';

class InfoWindowWidget extends StatelessWidget {
   final String name;
  final String clientName;
  final String phone;
  final String status;
   final void Function() function;

  const InfoWindowWidget(
      {super.key,
      required this.name,
      required this.clientName,
      required this.phone,
      required this.status,
      required this.function});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
   // final double screenwidth = MediaQuery.of(context).size.height;
    return Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NotoSansText(
              text: 'Colis name : laptop',
              size: 17,
            ),
            //  SizedBox(height: screenHeight/80.5),
            Row(
              children: [
                NotoSansText(
                  text: '$clientName ',
                  size: 15,
                  fontWeight: FontWeight.w600,
                ),
                //  Text("Hazem Hadda"),
                NotoSansText(
                  text: '92819124',
                  size: 15,
                  fontWeight: FontWeight.w600,
                ),

                IconButton(
                    onPressed: () async {
                      await makePhoneCall(phone);
                    },
                    icon: Icon(
                      Icons.phone,
                      color: const Color.fromARGB(255, 5, 110, 10),
                      size: screenHeight / 33.7,
                    )),
              ],
            ),
            Row(
              children: [
                NotoSansText(
                  text: 'Status :',
                  size: 17,
                  fontWeight: FontWeight.w800,
                ),
                NotoSansText(
                  text: status,
                  size: 15,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            SizedBox(
              height: screenHeight / 80.2,
            ),
            ButtonElevationWidget(
              titel: 'Change order Status ',
              onPressed:  function,
              width: 200,
            ),
          ],
        ));
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    try {
      await launchUrl(launchUri);
    } catch (e) {
      print("call error $launchUri error is $e");
    }
  }
}
