import 'package:delivery_app/cart/presintation/cubit/cart_cubit.dart';
import 'package:delivery_app/core/presentation/themes/app_colors.dart';
import 'package:delivery_app/core/presentation/themes/app_text_styles.dart';
import 'package:delivery_app/core/presentation/widgets/my_app_bar.dart';
import 'package:delivery_app/di/di_config.dart';
import 'package:delivery_app/home/presentation/bloc/home_cubit.dart';
import 'package:delivery_app/home/presentation/ui/widgets/recommended_product_item.dart';
import 'package:delivery_app/router/app_routes.dart';
import 'package:delivery_app/router/models/product_details_param.dart';
import 'package:delivery_app/search/presentation/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return Column(
              children: [
                MyAppBar(
                  allowShadow: false,
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h)
                          .copyWith(
                    top: MediaQuery.of(context).padding.top + 10.h,
                    bottom: 20.h,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.chevron_left_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      Expanded(child: _buildSearchBar(context)),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Builder(
                      builder: (context) {
                        if (state.status == SearchStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.status == SearchStatus.failure) {
                          return _screenMessage("Error: ${state.errorMessage}");
                        } else if (state.status == SearchStatus.success) {
                          if (state.results.isEmpty) {
                            return _screenMessage("No products found");
                          }
                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            itemCount: state.results.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16.h),
                            itemBuilder: (context, index) {
                              final product = state.results[index];
                              return RecommendedProductItem(
                                product: product,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.details,
                                  arguments: ProductDetailsParam(
                                    product: product,
                                    homeCubit: getIt<HomeCubit>(),
                                    cartCubit: getIt<CartCubit>(),
                                  ),
                                ),
                                width: double.infinity,
                              );
                            },
                          );
                        }
                        return _screenMessage("Start typing to search...");
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Center _screenMessage(String message) {
    return Center(
      child: Text(
        message,
        style: AppTextStyles.semiBold18.copyWith(color: AppColors.lightGrayC5),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      onChanged: (value) => context.read<SearchCubit>().search(value),
      decoration: InputDecoration(
        hintText: "Buscar",
        hintStyle: AppTextStyles.semiBold18.copyWith(
          color: AppColors
              .lightGrayC5, // Assuming this matches typical app bar title/hint style
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: AppColors.border, style: BorderStyle.solid),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: AppColors.primary, style: BorderStyle.solid),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        isDense: true,
      ),
      style: AppTextStyles.medium15.copyWith(color: Colors.black),
    );
  }
}
