import 'package:flutter/material.dart';
import 'package:intellio/infrastructure/theme/theme.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function()? onSuffixIconPressed;
  final int maxLines;
  final bool readOnly;

  const CustomFormField({
    Key? key,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onTap,
    this.onSuffixIconPressed,
    this.maxLines = 1,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _obscureText = obscureText;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          controller: controller,
          obscureText: _obscureText,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          onTap: onTap,
          readOnly: readOnly,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: r16.copyWith(),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon:
                isPassword
                    ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                        if (onSuffixIconPressed != null) {
                          onSuffixIconPressed!();
                        }
                      },
                    )
                    : suffixIcon != null
                    ? IconButton(
                      icon: Icon(suffixIcon),
                      onPressed: onSuffixIconPressed,
                    )
                    : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
    );
  }
}
