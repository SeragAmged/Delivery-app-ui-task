import 'package:delivery_app/core/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    required this.child,
    this.padding,
    this.allowShadow,
  });

  final Widget child;
  final bool? allowShadow;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ??
          EdgeInsets.only(
            top: kToolbarHeight + 16.h,
            bottom: 26.h,
            left: 18.w,
            right: 18.w,
          ),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: allowShadow == false
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 20,
                ),
              ],
      ),
      child: child,
    );
  }
}
