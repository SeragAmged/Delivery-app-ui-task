import 'package:delivery_app/assets/icons.dart';
import 'package:delivery_app/cart/presintation/cubit/cart_cubit.dart';
import 'package:delivery_app/cart/presintation/cubit/cart_state.dart';
import 'package:delivery_app/cart/presintation/widgets/cart_product_item.dart';
import 'package:delivery_app/core/presentation/themes/app_colors.dart';
import 'package:delivery_app/core/presentation/themes/app_text_styles.dart';
import 'package:delivery_app/core/presentation/widgets/animated_number.dart';
import 'package:delivery_app/core/presentation/widgets/app_gradient_button.dart';
import 'package:delivery_app/home/presentation/bloc/home_cubit.dart';
import 'package:delivery_app/router/app_routes.dart';
import 'package:delivery_app/router/models/product_details_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/presentation/widgets/my_app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      bloc: context.watch<CartCubit>(),
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                MyAppBar(
                  allowShadow: false,
                  child: Text(
                    'Carrito',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.semiBold22
                        .copyWith(color: AppColors.primary),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: state.addresses
                                .map(
                                  (address) => Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(end: 10.w),
                                    child: locationCard(
                                      onTap: () => context
                                          .read<CartCubit>()
                                          .selectAddress(address.id),
                                      title: address.name,
                                      subtitle: address.street,
                                      selected:
                                          address.id == state.selectedAddressId,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      MaterialButton(
                        color: AppColors.primary,
                        shape: const CircleBorder(),
                        elevation: 0,
                        padding: EdgeInsets.all(12.h),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 24.h,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 48.h),
                SizedBox(
                  height: 340.h,
                  // color: Colors.red,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.cart.length,
                    itemBuilder: (context, index) => CartProductItem(
                      cartProduct: state.cart[index],
                      margin: EdgeInsetsDirectional.only(
                        top: 20.h,
                        bottom: 20.h,
                        start: 16.w,
                        end: 22.w,
                      ),
                      onTab: () => Navigator.pushNamed(
                        context,
                        AppRoutes.details,
                        arguments: ProductDetailsParam(
                          product: state.cart[index].product,
                          homeCubit: context.read<HomeCubit>(),
                          cartCubit: context.read<CartCubit>(),
                        ),
                      ),
                      onDelete: () => context
                          .read<CartCubit>()
                          .removeProduct(state.cart[index]),
                      onIncreaseQuantity: () =>
                          context.read<CartCubit>().increaseQuantity(
                                state.cart[index],
                              ),
                      onDecreaseQuantity: () =>
                          context.read<CartCubit>().decreaseQuantity(
                                state.cart[index],
                              ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                _billAndPaymentCard(state)
              ],
            ),
          ),
        );
      },
    );
  }

  Container _billAndPaymentCard(CartState state) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrayF9,
        borderRadius: BorderRadius.circular(25),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: 22.w,
              left: 22.w,
              bottom: 13.h,
              top: 25.h,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SubTotal:',
                        style: AppTextStyles.regular11
                            .copyWith(color: AppColors.darkblue73)),
                    Text(
                      '\$${state.totalPrice} usd',
                      style: AppTextStyles.medium11
                          .copyWith(color: AppColors.darkblue73),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Envio:',
                      style: AppTextStyles.regular11.copyWith(
                        color: AppColors.darkblue73,
                      ),
                    ),
                    Text(
                      'Gratis',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.regular11.copyWith(
                        color: AppColors.darkblue73,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 13.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: AppTextStyles.semiBold17.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    AppAnimatedNumberText(
                      value: state.totalPrice,
                      style: AppTextStyles.semiBold17.copyWith(
                        color: AppColors.primary,
                      ),
                      prefix: "\$",
                      suffix: " usd",
                    )
                  ],
                ),
              ],
            ),
          ),
          AppGradientButton(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 18.h),
            child: Text(
              'Realizar compra',
              textAlign: TextAlign.center,
              style: AppTextStyles.medium18.copyWith(
                color: Colors.white,
              ),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Widget locationCard({
    required String title,
    required String subtitle,
    required bool selected,
    required void Function() onTap,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 12.h),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? Colors.transparent : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.iconsHome,
                color: selected ? Colors.white : AppColors.primary,
                height: 24.h,
                width: 24.h,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(width: 8.w),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.semiBold10.copyWith(
                      color: selected ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regular9.copyWith(
                      color: selected ? Colors.white : AppColors.lightGray65,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
