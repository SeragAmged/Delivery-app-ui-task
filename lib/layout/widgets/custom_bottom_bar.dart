import 'package:delivery_app/assets/icons.dart';
import 'package:delivery_app/assets/images.dart' as images;
import 'package:delivery_app/core/presentation/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30.0.h, left: 20.w, right: 20.w),
      child: Row(
        children: [
          Expanded(
            child: _bottomBarHalf(
              isRight: true,
              children: [
                _svgNavItem(svgPath: Assets.iconsHome, index: 0),
                _svgNavItem(svgPath: Assets.iconsShop, index: 1),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0.h),
            child: _cartNavItem(svgPath: Assets.iconsBasket, index: 2),
          ),
          Expanded(
            child: _bottomBarHalf(
              isRight: false,
              children: [
                _svgNavItem(svgPath: Assets.iconsFavorite, index: 3),
                _profileNavItem(
                    imagePath: images.Assets.imagesMiscProfile, index: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _svgNavItem({
    required String svgPath,
    required int index,
  }) {
    final bool isActive = index == currentIndex;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => onTap(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.all(6.0.h),
          child: AnimatedScale(
            scale: isActive ? 1.15 : 1.0,
            duration: const Duration(milliseconds: 160),
            child: SvgPicture.asset(
              svgPath,
              height: 20.h,
              width: 20.h,
              colorFilter: ColorFilter.mode(
                isActive ? AppColors.highlight : AppColors.grayBB,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cartNavItem({required String svgPath, required int index}) {
    final bool isActive = index == currentIndex;

    return AnimatedScale(
      duration: const Duration(milliseconds: 180),
      scale: isActive ? 1.15 : 1.0,
      child: Material(
        color: isActive ? AppColors.highlight : AppColors.primary,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => onTap(2),
          child: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: SvgPicture.asset(
              svgPath,
              height: 24.h,
              width: 24.h,
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileNavItem({required String imagePath, required int index}) {
    final bool isActive = index == currentIndex;

    return AnimatedScale(
      duration: const Duration(milliseconds: 180),
      scale: isActive ? 1.15 : 1.0,
      child: Material(
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          borderRadius: BorderRadius.circular(8),
          onTap: () => onTap(index),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.0.h, vertical: 6.0.h),
            child: Image.asset(
              imagePath,
              colorBlendMode: BlendMode.softLight,
              height: 24.h,
              width: 24.h,
            ),
          ),
        ),
      ),
    );
  }

  Widget _bottomBarHalf({
    required List<Widget> children,
    required bool isRight,
  }) {
    final hight = 70.h;
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 20,
          ),
        ],
      ),
      child: PhysicalShape(
        clipper: SideArcClipper(cutHeight: hight, cutRight: isRight),
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: hight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10.w,
            children: children,
          ),
        ),
      ),
    );
  }
}

class SideArcClipper extends CustomClipper<Path> {
  final double borderRadius;
  final bool cutRight;
  final double cutHeight;

  SideArcClipper({
    this.borderRadius = 22,
    this.cutRight = true,
    this.cutHeight = 70,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final double topArc = (size.height - cutHeight) / 2;
    final double bottomArc = topArc + cutHeight;

    if (cutRight) {
      // Top-left corner
      path.moveTo(0, borderRadius);
      path.quadraticBezierTo(0, 0, borderRadius, 0);

      // Top edge
      path.lineTo(size.width, 0);

      // Arc cut on right side
      path.lineTo(size.width, topArc);
      path.quadraticBezierTo(
        size.width - cutHeight / 2,
        size.height / 2,
        size.width,
        bottomArc,
      );

      // Bottom edge
      path.lineTo(size.width, size.height);
      path.lineTo(borderRadius, size.height);

      // Bottom-left corner
      path.quadraticBezierTo(0, size.height, 0, size.height - borderRadius);
    } else {
      // Top-right corner
      path.moveTo(size.width, borderRadius);
      path.quadraticBezierTo(size.width, 0, size.width - borderRadius, 0);

      // Top edge
      path.lineTo(0, 0);

      // Arc cut on left side
      path.lineTo(0, topArc);
      path.quadraticBezierTo(
        cutHeight / 2,
        size.height / 2,
        0,
        bottomArc,
      );

      // Bottom edge
      path.lineTo(0, size.height);
      path.lineTo(size.width - borderRadius, size.height);

      // Bottom-right corner
      path.quadraticBezierTo(
          size.width, size.height, size.width, size.height - borderRadius);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
