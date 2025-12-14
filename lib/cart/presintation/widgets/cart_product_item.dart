import 'package:delivery_app/assets/icons.dart';
import 'package:delivery_app/core/presentation/themes/app_colors.dart';
import 'package:delivery_app/core/presentation/themes/app_text_styles.dart';
import 'package:delivery_app/core/presentation/widgets/animated_number.dart';
import 'package:delivery_app/cart/domain/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem(
      {super.key,
      required this.cartProduct,
      this.margin,
      required this.onTab,
      required this.onDelete,
      required this.onIncreaseQuantity,
      required this.onDecreaseQuantity});
  final CartProduct cartProduct;
  final EdgeInsetsGeometry? margin;

  final void Function() onTab;
  final void Function() onDelete;
  final void Function() onIncreaseQuantity;
  final void Function() onDecreaseQuantity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Stack(
        children: [
          Container(
            width: 240.w,
            height: 300.h,
            margin: margin,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(15),
                  blurRadius: 20,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _productImage(),
                SizedBox(height: 16.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartProduct.product.name,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.semiBold19.copyWith(
                        color: AppColors.darkblue73,
                      ),
                    ),
                    Text(
                      cartProduct.product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.light10
                          .copyWith(color: AppColors.lightGray7E),
                    ),
                  ],
                ),
                Flexible(child: SizedBox(height: 16.h)),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // spacing: 10.w,
                    children: [
                      _decreaseButton(context),
                      Text(
                        cartProduct.quantity.toString(),
                        style: AppTextStyles.medium15
                            .copyWith(color: AppColors.primary),
                      ),
                      _increaseButton(context),
                      AppAnimatedNumberText(
                        prefix: '\$',
                        suffix: '',
                        style: AppTextStyles.semiBold20
                            .copyWith(color: AppColors.highlight),
                        value: (cartProduct.product.price * cartProduct.quantity),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Transform.translate(
              offset: Offset(15.h, 5.h),
              child: _deleteButton(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _deleteButton(BuildContext context) {
    return MaterialButton(
      onPressed: onDelete,
      shape: CircleBorder(),
      elevation: 0,
      padding: EdgeInsets.all(8.h),
      color: AppColors.red5E,
      child: SvgPicture.asset(
        Assets.iconsTrash,
        color: Colors.white,
        height: 24.h,
        width: 24.h,
        fit: BoxFit.scaleDown,
      ),
    );
  }

  Widget _increaseButton(BuildContext context) {
    return MaterialButton(
      onPressed: onIncreaseQuantity,
      minWidth: 22.h,
      height: 22.h,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      padding: EdgeInsets.zero,
      color: AppColors.primary,
      child: Icon(
        Icons.add,
        size: 24.h,
        color: Colors.white,
      ),
    );
  }

  Widget _decreaseButton(BuildContext context) {
    return MaterialButton(
      onPressed: onDecreaseQuantity,
      minWidth: 22.h,
      height: 22.h,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      padding: EdgeInsets.zero,
      color: AppColors.lightGrayF3.withAlpha(200),
      child: Icon(
        Icons.remove,
        size: 24.h,
        color: AppColors.primary,
      ),
    );
  }

  Widget _productImage() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(cartProduct.product.imagePreview),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
      height: 95.h,
      width: 95.h,
    );
  }
}
