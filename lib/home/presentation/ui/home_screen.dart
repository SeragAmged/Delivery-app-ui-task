import 'package:delivery_app/cart/presintation/cubit/cart_cubit.dart';
import 'package:delivery_app/core/presentation/themes/app_text_styles.dart';
import 'package:delivery_app/home/domain/product.dart';
import 'package:delivery_app/home/presentation/bloc/home_cubit.dart';
import 'package:delivery_app/home/presentation/ui/widgets/category_item.dart';
import 'package:delivery_app/core/presentation/widgets/my_app_bar.dart';
import 'package:delivery_app/home/presentation/ui/widgets/popular_product_item.dart';
import 'package:delivery_app/home/presentation/ui/widgets/recommended_product_item.dart';
import 'package:delivery_app/assets/icons.dart';
import 'package:delivery_app/core/presentation/themes/app_colors.dart';
import 'package:delivery_app/core/presentation/widgets/material_svg_button.dart';
import 'package:delivery_app/router/app_routes.dart';
import 'package:delivery_app/router/models/product_details_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final categories = state.categories;
          final popularProducts = state.popularProducts;
          final recommendedProducts = state.recommendedProducts;
          return Scaffold(
            backgroundColor: AppColors.background,
            body: Column(
              children: [
                appBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 8.h),
                        homeCategoryTitle(context,
                            title: 'Explorar categorias', onReadMore: () {}),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 16.w, top: 1.h, bottom: 30.h),
                          child: SizedBox(
                            height: 100.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (_, index) =>
                                  SizedBox(width: 32.w),
                              itemBuilder: (_, index) =>
                                  CategoryItem(foodCategory: categories[index]),
                              itemCount: categories.length,
                            ),
                          ),
                        ),
                        homeCategoryTitle(context,
                            title: 'Productos populares'),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: 16.w,
                            top: 16.h,
                            bottom: 33.h,
                          ),
                          child: Container(
                            height: 225.h,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(8),
                                blurRadius: 20,
                              ),
                            ]),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: popularProducts.length,
                              separatorBuilder: (_, index) =>
                                  SizedBox(width: 8.w),
                              itemBuilder: (_, index) => PopularProductItem(
                                product: popularProducts[index],
                                onFavTap: () => context
                                    .read<HomeCubit>()
                                    .favoriteProduct(popularProducts[index]),
                                onTap: () => navigateToFoodPage(
                                  context,
                                  popularProducts[index],
                                  context.read<HomeCubit>(),
                                  context.read<CartCubit>(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        homeCategoryTitle(context, title: 'Recomendados'),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 16.w, top: 16.h),
                          child: Container(
                            height: 150.h,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(8),
                                blurRadius: 20,
                              ),
                            ]),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: recommendedProducts.length,
                              separatorBuilder: (_, index) =>
                                  SizedBox(width: 8.w),
                              itemBuilder: (_, index) => RecommendedProductItem(
                                product: recommendedProducts[index],
                                onFavTap: () => context
                                    .read<HomeCubit>()
                                    .favoriteProduct(
                                        recommendedProducts[index]),
                                onTap: () => navigateToFoodPage(
                                  context,
                                  recommendedProducts[index],
                                  context.read<HomeCubit>(),
                                  context.read<CartCubit>(),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget homeCategoryTitle(BuildContext context,
      {required String title, void Function()? onReadMore}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Row(
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: AppColors.secondary)),
          Spacer(),
          if (onReadMore != null)
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Ver todos',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.lightGrayCF),
              ),
            ),
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return MyAppBar(
        child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        searchTextFieldButton(
          context,
          () {
            //TODO: Navigate To search Screen
          },
        ),
        SizedBox(width: 8.w),
        Text(
          'Inicio',
          textAlign: TextAlign.center,
          style: AppTextStyles.semiBold22.copyWith(color: AppColors.primary),
        ),
        Spacer(),
        MaterialSvgButton(
            child: SvgPicture.asset(Assets.iconsNotification,
                height: 24.h, width: 24.h)),
        MaterialSvgButton(
            child:
                SvgPicture.asset(Assets.iconsSales, height: 24.h, width: 24.h)),
      ],
      // remove default shadow
    ));
  }

  Widget searchTextFieldButton(BuildContext context, void Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          shape: BoxShape.rectangle,
          border: Border.all(color: AppColors.border),
        ),
        padding: EdgeInsetsDirectional.only(
          top: 4.h,
          bottom: 4.h,
          start: 12.w,
          end: 64.w,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              Assets.iconsSearch,
              height: 24.h,
              width: 24.h,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(width: 8.w),
            Text(
              'Buscar',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey, height: 0.15),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToFoodPage(
      context, Product product, HomeCubit homeCubit, CartCubit cartCubit) {
    Navigator.pushNamed(
      context,
      AppRoutes.details,
      arguments: ProductDetailsParam(
        product: product,
        homeCubit: homeCubit,
        cartCubit: cartCubit,
      ),
    );
  }
}
