import 'package:flutter/material.dart';

import 'text_subtitle_widget.dart';

class AddressSectionWidget extends StatelessWidget {
  final String title;

  final Widget widget;

  AddressSectionWidget({
    required this.title,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextSubTitile(subTitle: title),
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Expanded(child: widget)
          ],
        ),
      ],
    );
  }
}
