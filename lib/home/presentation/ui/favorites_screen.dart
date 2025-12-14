import 'package:delivery_app/cart/presintation/cubit/cart_cubit.dart';
import 'package:delivery_app/core/presentation/themes/app_colors.dart';
import 'package:delivery_app/core/presentation/themes/app_text_styles.dart';
import 'package:delivery_app/core/presentation/widgets/my_app_bar.dart';
import 'package:delivery_app/home/presentation/bloc/home_cubit.dart';
import 'package:delivery_app/home/presentation/ui/widgets/recommended_product_item.dart';
import 'package:delivery_app/router/app_routes.dart';
import 'package:delivery_app/router/models/product_details_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              MyAppBar(
                allowShadow: false,
                child: Text(
                  "Favorites",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.semiBold22
                      .copyWith(color: AppColors.primary),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: state.favoriteProducts.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        blurRadius: 20,
                      ),
                    ]),
                    child: RecommendedProductItem(
                      width: double.infinity,
                      product: state.favoriteProducts[index],
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.details,
                        arguments: ProductDetailsParam(
                          product: state.favoriteProducts[index],
                          homeCubit: context.read<HomeCubit>(),
                          cartCubit: context.read<CartCubit>(),
                        ),
                      ),
                      onFavTap: () => context
                          .read<HomeCubit>()
                          .favoriteProduct(state.favoriteProducts[index]),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
