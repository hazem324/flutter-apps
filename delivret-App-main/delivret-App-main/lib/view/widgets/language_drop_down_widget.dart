import 'package:deliveryapp/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../../model/language_model.dart';
import '../../utils/language_constant.dart';

class LanguageDropDownWidget extends StatefulWidget {
  const LanguageDropDownWidget({super.key});

  @override
  LanguageDropDownWidgetState createState() => LanguageDropDownWidgetState();
}

class LanguageDropDownWidgetState extends State<LanguageDropDownWidget> {
  LanguageModel? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width:100,
    height: 50,
     // padding: const  EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
       // color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<LanguageModel>(
          dropdownColor : AppColors.white,
            hint: selectedLanguage != null
              ? Row(
                  children: <Widget>[
                    Text(
                      selectedLanguage!.flag,
                      style: TextStyle(fontSize: size.height / 26.8),
                    ),
                    SizedBox(width: size.width / 33.08),
                    Text(
                      selectedLanguage!.name,
                      style: TextStyle(fontSize: size.height / 50.25),
                    )
                  ],
                )
              : Text(
                  translation(context).select_lan,
                  style: GoogleFonts.montserrat(
                    color: Colors.grey,
                    fontSize: size.height / 50.25,
                  ),
                ),
          value: selectedLanguage,
          onChanged: (LanguageModel? language) async {
            if (language != null) {
              Locale locale = await setLocale(language.languageCode);
              MyApp.setLocale(context, locale);
              setState(() {
                selectedLanguage = language;
              });
            }
          },
          items: LanguageModel.languageList()
              .map<DropdownMenuItem<LanguageModel>>(
                (e) => DropdownMenuItem<LanguageModel>(
                  value: e,
                  child: Row(
                    children: <Widget>[
                      Text(
                        e.flag,
                        style:  TextStyle(fontSize: size.height/27.8),
                      ),
                      SizedBox(width: size.width/33.08),
                      Text(
                        e.name,
                        style: TextStyle(fontSize: size.height/52.25),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
             
        ),
      ),
    );
  }
}
