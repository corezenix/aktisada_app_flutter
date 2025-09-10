import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class SearchField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final bool autoFocus;
  final Duration? debounceTime;

  const SearchField({
    super.key,
    this.hintText = 'Search...',
    this.onChanged,
    this.onClear,
    this.controller,
    this.autoFocus = false,
    this.debounceTime,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController _controller;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value) {
    if (widget.debounceTime != null) {
      _debounceTimer?.cancel();
      _debounceTimer = Timer(widget.debounceTime!, () {
        widget.onChanged?.call(value);
      });
    } else {
      widget.onChanged?.call(value);
    }
  }

  void _onClear() {
    _controller.clear();
    widget.onClear?.call();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: TextField(
        controller: _controller,
        autofocus: widget.autoFocus,
        onChanged: _onChanged,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTextStyles.base.s14.greyTextColor(),
          prefixIcon: Icon(Icons.search, color: AppColors.grey, size: 20.sp),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: AppColors.grey, size: 20.sp),
                  onPressed: _onClear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          isDense: true,
        ),
      ),
    );
  }
}
