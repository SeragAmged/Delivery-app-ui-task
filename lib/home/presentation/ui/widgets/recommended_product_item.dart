import 'package:delivery_app/core/domain/product.dart';
import 'package:delivery_app/assets/icons.dart';
import 'package:delivery_app/core/presentation/themes/app_colors.dart';
import 'package:delivery_app/core/presentation/themes/app_text_styles.dart';
import 'package:delivery_app/core/presentation/widgets/material_svg_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RecommendedProductItem extends StatelessWidget {
  const RecommendedProductItem({
    super.key,
    required this.product,
    required this.onTap,
     this.onFavTap,
    this.width,
  });

  final Product product;
  final VoidCallback onTap;
  final VoidCallback? onFavTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 270.w,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            card(),
            image(),
          ],
        ),
      ),
    );
  }

  Widget image() {
    return Positioned(
      top: 20.h,
      left: 0.w,
      child: SizedBox(
        height: 135.h,
        width: 100.w,
        child: Image.asset(
          product.imagePreview,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  Widget card() {
    return Container(
      width: width,
      height: 120.h,
      padding: EdgeInsetsDirectional.only(
        start: 100.w,
        end: 16.w,
        top: 16.h,
        bottom: 8.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  product.type,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.light10.copyWith(
                    color: AppColors.lightGrayC5,
                  ),
                ),
              ),
              if (onFavTap != null)
                MaterialSvgButton(
                  onTap: onFavTap,
                  child: SvgPicture.asset(
                    product.isFavorite
                        ? Assets.iconsFavoriteFiled
                        : Assets.iconsFavorite,
                    height: 15.h,
                    width: 15.h,
                  ),
                ),
            ],
          ),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                AppTextStyles.regular10.copyWith(color: AppColors.darkblue73),
          ),
          Text(
            product.shortDescription,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.light7.copyWith(color: AppColors.lightGray65),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Text(
                  '\$${product.price}',
                  style: AppTextStyles.semiBold14
                      .copyWith(color: AppColors.darkblue73),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(18),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: Icon(
                    Icons.chevron_right_rounded,
                    size: 20.h,
                    color: AppColors.darkblue73,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
