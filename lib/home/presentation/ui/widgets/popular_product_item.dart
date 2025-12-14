import 'package:delivery_app/core/domain/product.dart';
import 'package:delivery_app/assets/icons.dart';
import 'package:delivery_app/core/presentation/themes/app_colors.dart';
import 'package:delivery_app/core/presentation/themes/app_text_styles.dart';
import 'package:delivery_app/core/presentation/widgets/material_svg_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PopularProductItem extends StatelessWidget {
  const PopularProductItem({
    super.key,
    required this.product,
    required this.onTap,
    required this.onFavTap,
    this.width,
  });

  final Product product;
  final void Function() onTap;
  final void Function() onFavTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 180.w,
        constraints: BoxConstraints(
          minHeight: 200.h,
          maxHeight: 260.h,
        ),
        padding: EdgeInsetsDirectional.only(
          start: 8.w,
          end: 16.w,
          top: 16.h,
          bottom: 4.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // fav button
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: MaterialSvgButton(
                onTap: onFavTap,
                child: SvgPicture.asset(
                  product.isFavorite
                      ? Assets.iconsFavoriteFiled
                      : Assets.iconsFavorite,
                  height: 15.h,
                  width: 15.h,
                ),
              ),
            ),

            SizedBox(height: 8.h),

            // image (NO Expanded here)
            SizedBox(
              height: 100.h,
              width: 100.h,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightblueD0.withAlpha(70),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(8.h),
                  child: Center(
                    child: Image.asset(
                      product.imagePreview,
                      height: 90.h,
                      width: 90.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // info section
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: AppTextStyles.regular12.copyWith(
                              color: AppColors.lightGray65,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            product.shortDescription,
                            style: AppTextStyles.light7.copyWith(
                              color: AppColors.lightGray65,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            '\$${product.price}',
                            style: AppTextStyles.semiBold14.copyWith(
                              color: AppColors.darkblue73,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // right arrow
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
                      padding: EdgeInsets.all(8.h),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.darkblue73,
                        size: 24.h,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
