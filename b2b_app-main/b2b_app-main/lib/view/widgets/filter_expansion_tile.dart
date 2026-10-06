import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class FilterExpansionTile extends StatefulWidget {
  final String title;
  final List<String> items;
  final Map<String, bool> selectedItems;
  final ValueChanged<bool> onExpansionChanged;
  final ValueChanged<Map<String, bool>> onSelectionChanged;

  const FilterExpansionTile({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.onExpansionChanged,
    required this.onSelectionChanged,
  });

  @override
  FilterExpansionTileState createState() => FilterExpansionTileState();
}

class FilterExpansionTileState extends State<FilterExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.1,
          color: AppColors.textColor,
        ),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_down,
        size: 30,
        color: AppColors.primary,
      ),
      onExpansionChanged: widget.onExpansionChanged,
      children: [
       
        SizedBox(
          height: 250.h, 
          child: widget.items.isEmpty
              ? const Center(
                  child: Text('No items available'),
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    return CheckboxListTile(
                      activeColor: AppColors.primary,
                      title: Text(
                        item,
                        style: TextStyle(
                          fontSize: 18.sp,
                          letterSpacing: 1.1.w,
                          fontWeight: FontWeight.w200,
                          color: AppColors.textColor,
                        ),
                      ),
                      value: widget.selectedItems[item] ?? false,
                      onChanged: (bool? value) {
                        if (value != null) {
                          setState(() {
                            widget.selectedItems[item] = value;
                            widget.onSelectionChanged(
                                Map<String, bool>.from(widget.selectedItems));
                          });
                        }
                      },
                    );
                  },
                ),
        )
      ],
    );
  }
}
