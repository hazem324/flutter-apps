import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;


  const ChatAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return AppBar(
      backgroundColor: AppColors.white,
      leadingWidth:100,
      titleSpacing: 0,
      leading: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.primary,
              size: screenHeight / 32.11,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
              width: 10), 
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blueGrey,
            backgroundImage: AssetImage('assets/images/hazemhadda.jpg'),
          ),
        ],
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
