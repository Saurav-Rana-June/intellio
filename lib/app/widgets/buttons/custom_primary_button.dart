import 'package:flutter/material.dart';

import '../../../infrastructure/theme/theme.dart';

class CustomPrimaryButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? borderColor;
  final Color? buttonShadowColor;
  final String label;
  final double? labelFontSize;
  final double? borderSize;
  final double? borderRadius;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final bool? isDisabled;
  final bool? isLoading;
  final bool? isInkWellDisabled;
  final double height;
  final Function() onTap;

  const CustomPrimaryButton({
    Key? key,
    this.buttonColor,
    this.borderColor,
    this.buttonShadowColor,
    required this.label,
    this.labelFontSize,
    this.borderSize,
    this.borderRadius,
    this.icon,
    this.iconColor,
    this.textColor,
    required this.onTap,
    this.isDisabled = false,
    this.isLoading = false,
    this.isInkWellDisabled = false,
    this.height = 45.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius ?? 46),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: isDisabled!
              ? Theme.of(context).disabledColor.withOpacity(0.1)
              : buttonColor != null
              ? buttonColor
              : Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: isDisabled!
                  ? buttonShadowColor != null
                  ? buttonShadowColor!.withOpacity(0)
                  : Theme.of(context).primaryColor.withOpacity(0)
                  : buttonShadowColor != null
                  ? buttonShadowColor!
                  : Theme.of(context).primaryColor.withOpacity(0.0),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(borderRadius ?? 46),
          border: Border.all(width: borderSize ?? 0, color: borderColor ?? Theme.of(context).primaryColor),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            enableFeedback: isInkWellDisabled! ? false : true,
            splashFactory: isInkWellDisabled! ? NoSplash.splashFactory : null,
            onTap: isDisabled! ? null : onTap,
            borderRadius: BorderRadius.circular(borderRadius ?? 46),
            child: Opacity(
              opacity: isDisabled! ? 0.8 : 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLoading!
                        ? Container(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.only(
                        right: 10.0,
                      ),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(primary),
                        strokeWidth: 2.0,
                      ),
                    )
                        : Container(),
                    icon != null
                        ? Icon(
                      icon,
                      color: isDisabled! ? white : iconColor,
                      size: 18,
                    )
                        : Container(),
                    icon != null ? const SizedBox(width: 5) : Container(),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: labelFontSize ?? 20,
                        color: isLoading!
                            ? null
                            : (textColor != null
                            ? isDisabled!
                            ? Theme.of(context).disabledColor.withOpacity(0.5)
                            : textColor
                            : white),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
