import 'package:delivery_app/core/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';

class AppGradientButton extends StatelessWidget {
  const AppGradientButton({
    super.key,
    this.height,
    this.width,
    this.padding,
    this.onTap,
    required this.child,
  });
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Widget child;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          height: height,
          width: width,
          padding: padding,
          decoration: onTap == null
              ? null
              : const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
          color: onTap == null ? AppColors.grayBB : null,
          child: child,
        ),
      ),
    );
  }
}
