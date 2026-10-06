import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

typedef OnDateSelected = void Function(DateTime? selectedDate);

class CustomDatePicker extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final OnDateSelected onDateSelected;

  const CustomDatePicker({
    Key? key,
    required this.label,
    required this.selectedDate,
    this.minDate,
    this.maxDate,
    required this.onDateSelected,
  }) : super(key: key);

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: minDate ?? DateTime(2021),
      lastDate: maxDate ?? DateTime(now.year + 5),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.w,
      child: OutlinedButton(
        onPressed: () => _showDatePicker(context),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
          side: BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          backgroundColor: AppColors.primaryBackground,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate != null
                  ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                  : label,
              style: TextStyle(
                fontSize: 14.sp,
                color: selectedDate != null
                    ? AppColors.primary
                    : AppColors.lightGreyTextColor,
              ),
            ),
            Icon(Icons.calendar_today, size: 20.sp, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
