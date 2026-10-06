import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';

class FilterExpansionTileSingle extends StatefulWidget {
  final String title;
  final List<Map<String, String>> items; 
  final String? selectedValue; 
  final ValueChanged<bool> onExpansionChanged;
  final ValueChanged<String?> onSelectionChanged;

  const FilterExpansionTileSingle({
    super.key,
    required this.title,
    required this.items,
    required this.selectedValue,
    required this.onExpansionChanged,
    required this.onSelectionChanged,
  });

  @override
  State<FilterExpansionTileSingle> createState() => _FilterExpansionTileSingleState();
}

class _FilterExpansionTileSingleState extends State<FilterExpansionTileSingle> {
  String? selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selectedValue;
  }

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
          height: 150.h,
          child: widget.items.isEmpty
              ? const Center(child: Text('No items available'))
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    final label = item['label']!;
                    final value = item['value']!;

                    return RadioListTile<String>(
                      activeColor: AppColors.primary,
                      title: Text(
                        label,
                        style: TextStyle(
                          fontSize: 18.sp,
                          letterSpacing: 1.1.w,
                          fontWeight: FontWeight.w200,
                          color: AppColors.textColor,
                        ),
                      ),
                      value: value,
                      groupValue: selected,
                      onChanged: (newValue) {
                        setState(() {
                          selected = newValue;
                          widget.onSelectionChanged(selected);
                        });
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}
