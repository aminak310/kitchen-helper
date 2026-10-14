import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Reusable modern button matching the Kitchen Helper design system.
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double height;
  final double borderRadius;
  final bool isLoading;
  final bool isOutlined;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height = 52.0,
    this.borderRadius = 16.0,
    this.isLoading = false,
    this.isOutlined = false,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w600,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBg = isOutlined
        ? Colors.transparent
        : (backgroundColor ?? AppColors.primary);
    final effectiveTextColor = isOutlined
        ? (textColor ?? AppColors.primary)
        : (textColor ?? Colors.white);
    final effectiveBorder = isOutlined
        ? Border.all(
            color: borderColor ?? AppColors.primary,
            width: 1.5,
          )
        : (borderColor != null ? Border.all(color: borderColor!, width: 1.5) : null);

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: effectiveBg,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: (isOutlined ? AppColors.primary : Colors.white).withValues(alpha: 0.2),
          highlightColor: (isOutlined ? AppColors.primary : Colors.white).withValues(alpha: 0.1),
          child: Container(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: effectiveBorder,
            ),
            alignment: Alignment.center,
            child: isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      valueColor: AlwaysStoppedAnimation<Color>(effectiveTextColor),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, color: effectiveTextColor, size: 20),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        text,
                        style: TextStyle(
                          color: effectiveTextColor,
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
