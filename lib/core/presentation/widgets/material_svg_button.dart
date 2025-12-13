import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaterialSvgButton extends StatelessWidget {
  const MaterialSvgButton({super.key, required this.child, this.onTap});

  final Widget child;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap ?? () {},
        child: Padding(
          padding: EdgeInsets.all(6.0.h),
          child: child,
        ),
      ),
    );
  }
}
