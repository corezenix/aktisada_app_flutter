import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class SearchableDropdown<T> extends StatelessWidget {
  final String label;
  final String? hintText;
  final T? value;
  final List<T> options;
  final Function(T?) onChanged;
  final String Function(T) displayValue;
  final bool isMandatory;
  final String? errorText;
  final bool isLabelVisible;
  final bool Function(T, T)? compareFn;

  const SearchableDropdown({
    super.key,
    required this.label,
    this.hintText,
    required this.value,
    required this.options,
    required this.onChanged,
    required this.displayValue,
    this.isMandatory = false,
    this.errorText,
    this.isLabelVisible = true,
    this.compareFn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isLabelVisible)
          Row(
            children: [
              Text(label, style: AppTextStyles.base.w500.s14.labelColor()),
              if (isMandatory)
                Text(' *', style: AppTextStyles.base.w500.s14.primaryColor()),
            ],
          ),
        if (isLabelVisible) SizedBox(height: 6.h),

        DropdownSearch<T>(
          selectedItem: value,

          // Provide items via the required function signature
          items: (String filter, LoadProps? loadProps) async {
            if (filter.isEmpty) {
              return options;
            }
            return options
                .where(
                  (option) => displayValue(
                    option,
                  ).toLowerCase().contains(filter.toLowerCase()),
                )
                .toList();
          },

          // How to display each item as string
          itemAsString: displayValue,
          onChanged: onChanged,
          // Provide compareFn for non-primitive T (dropdown_search assertion)
          compareFn: (a, b) {
            if (compareFn != null) return compareFn!(a, b);
            // Fallback: compare by display string
            return displayValue(a) == displayValue(b);
          },

          // Use decoratorProps for input styling
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: hintText ?? 'Select',
              hintStyle: AppTextStyles.base.w400.s12
                  .greyTextColor(), // Reduced from s14 to s12
              errorText: errorText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide(color: AppColors.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.h,
              ),
            ),
          ),

          popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: AppTextStyles.base.w400.s12
                    .greyTextColor(), // Reduced from s14 to s12
                prefixIcon: Icon(Icons.search, size: 20.sp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
              ),
            ),
            constraints: BoxConstraints(
              maxHeight: 300.h, // Increased height for better visibility
              minHeight: 100.h,
            ),
            showSelectedItems: true,
            fit: FlexFit.loose, // Allow popup to size naturally
            searchDelay: const Duration(
              milliseconds: 300,
            ), // Add slight delay for better UX
            // Improve scrolling behavior
            scrollbarProps: const ScrollbarProps(
              thumbColor: AppColors.primary,
              trackColor: AppColors.borderColor,
            ),
          ),
        ),
      ],
    );
  }
}
