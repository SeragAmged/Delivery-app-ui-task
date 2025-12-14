import 'package:delivery_app/assets/icons.dart';
import 'package:delivery_app/cart/presintation/cubit/cart_cubit.dart';
import 'package:delivery_app/cart/presintation/cubit/cart_state.dart';
import 'package:delivery_app/core/presentation/themes/app_colors.dart';
import 'package:delivery_app/core/presentation/themes/app_text_styles.dart';
import 'package:delivery_app/core/domain/ingredient.dart';
import 'package:delivery_app/core/domain/product.dart';
import 'package:delivery_app/home/presentation/bloc/home_cubit.dart';
import 'package:delivery_app/core/presentation/widgets/app_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final double imageHight = MediaQuery.of(context).size.height * 0.55;
    final double overLappingHeight = 70.h;
    final double favIconSize = 50.h;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          product.name,
          style: AppTextStyles.h3.copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      _backgroundImage(imageHight),
                      Transform.translate(
                        offset: Offset(0, -overLappingHeight),
                        child: _detailsContainer(_details()),
                      ),
                    ],
                  ),
                  Positioned(
                    top: imageHight - overLappingHeight - favIconSize / 2 - 5.h,
                    right: 26.w,
                    child: favButton(favIconSize),
                  ),
                ],
              ),
            ),
          ),
          _addToCart(),
        ],
      ),
    );
  }

  Container _addToCart() {
    return Container(
      height: 125.h,
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(
            color: Color(0xFF707070),
            width: .2,
          ),
        ),
      ),
      padding: EdgeInsetsDirectional.symmetric(
        vertical: 30.h,
        horizontal: 24.w,
      ),
      child: Row(
        children: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final isInCart = state.products.contains(product);
              return AppGradientButton(
                padding: EdgeInsets.symmetric(
                  horizontal: 50.w,
                  vertical: 18.h,
                ),
                onTap: isInCart
                    ? null
                    : () {
                        context.read<CartCubit>().addProduct(product);
                      },
                child: Text(
                  isInCart ? 'en el carrito' : 'Ordenar ahora',
                  style: AppTextStyles.medium18.copyWith(color: Colors.white),
                ),
              );
            },
          ),
          Spacer(),
          Text(
            '\$${product.price}',
            style:
                AppTextStyles.semiBold30.copyWith(color: AppColors.darkblue73),
          )
        ],
      ),
    );
  }

  Column _details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            end: 32.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Descripción',
                style: AppTextStyles.semiBold18
                    .copyWith(color: AppColors.darkblue73),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: 4.h,
                  bottom: 24.h,
                ),
                child: Text(
                  product.description,
                  style: AppTextStyles.light10
                      .copyWith(color: AppColors.darkblue73),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ingredientes',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.semiBold18
                        .copyWith(color: AppColors.darkblue73),
                  ),
                  Text(
                    '${product.ingredients.length} ingredientes',
                    style: AppTextStyles.light10.copyWith(
                      color: AppColors.lightGray65,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 130.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 10.w),
            itemCount: product.ingredients.length,
            itemBuilder: (context, index) => _ingredientItem(
              ingredient: product.ingredients[index],
            ),
          ),
        )
      ],
    );
  }

  Container _detailsContainer(Column column) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.only(
        top: 46.h,
        start: 46.w,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
      ),
      child: column,
    );
  }

  BlocBuilder<HomeCubit, HomeState> favButton(double favIconSize) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final allProducts = [
          ...state.popularProducts,
          ...state.recommendedProducts,
        ];

        final updatedFood = allProducts.firstWhere(
          (p) => p.id == product.id,
          orElse: () => product,
        );

        return Material(
          color: AppColors.red5E,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: () => cubit.favoriteProduct(product),
            customBorder: const CircleBorder(),
            child: SizedBox(
              height: favIconSize,
              width: favIconSize,
              child: Center(
                child: SvgPicture.asset(
                  updatedFood.isFavorite
                      ? Assets.iconsFavoriteFiled
                      : Assets.iconsFavorite,
                  color: Colors.white,
                  height: 18.h,
                  width: 18.h,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _ingredientItem({required Ingredient ingredient}) {
    return Column(
      children: [
        Container(
          width: 91.w,
          height: 104.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ingredient.image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Spacer(),
        Text(
          ingredient.name,
          style: AppTextStyles.light10.copyWith(color: AppColors.lightGray9A),
        ),
      ],
    );
  }

  Widget _backgroundImage(double imageHight) {
    return Container(
      height: imageHight,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(product.image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.elliptical(400.w, 120.h),
        ),
      ),
    );
  }
}
