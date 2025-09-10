import 'package:aktisada/core/constants/app_colors.dart';
import 'package:aktisada/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppFormField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final Widget? prefix;
  final Key? obscureTextKey;
  final TextInputType keyboardType;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const AppFormField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    required this.hintText,
    this.prefix,
    this.obscureTextKey,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.onChanged,
    this.validator,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void toggleObscure() {
    if (widget.isPassword) {
      setState(() => _obscureText = !_obscureText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextStyles.base.w500.s12.l2.labelColor()),
        const SizedBox(height: 6),
        TextFormField(
          key: widget.obscureTextKey,
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTextStyles.base.w500.s12.l2.greyTextColor(),
            errorText: widget.errorText,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.borderColor,
              ), // Or any focus color
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
            prefixIcon: widget.prefix,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.grey,
                    ),
                    onPressed: toggleObscure,
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ],
    );
  }
}
