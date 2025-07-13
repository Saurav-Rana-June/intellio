import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
            hintStyle: r16.copyWith(color: regular50),
            prefixIcon: Icon(prefixIcon, color: regular50),
            suffixIcon:
                isPassword
                    ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: regular50,
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
            filled: true,
            fillColor: regular50.withValues(alpha: 0.3),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              borderSide: BorderSide(
                width: 1.5,
                color: Theme.of(context).dividerColor,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              borderSide: BorderSide(width: 1.5, color: primary),
            ),
            errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              borderSide: BorderSide(width: 1.5, color: dangerColor),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              borderSide: BorderSide(width: 1.5, color: dangerColor),
            ),
          ),
        );
      },
    );
  }
}
