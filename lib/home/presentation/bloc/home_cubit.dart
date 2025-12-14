import 'dart:developer';

import 'package:delivery_app/home/data/home_products_repo.dart';
import 'package:delivery_app/home/domain/food_category.dart';
import 'package:delivery_app/core/domain/product.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@LazySingleton()
class HomeCubit extends HydratedCubit<HomeState> {
  final HomeProductsRepo _repo;
  HomeCubit(this._repo)
      : super(
          HomeState(
            categories: [],
            recommendedProducts: [],
            popularProducts: [],
            favoriteProductIds: [],
            isLoadingCategories: false,
            isLoadingRecommendedProducts: false,
            isLoadingPopularProducts: false,
          ),
        ) {
    log("HomeCubit created");
  }

  void loadCategories() {
    emit(state.copyWith(isLoadingCategories: true));
    _repo.getProductCategories().then((categories) {
      emit(state.copyWith(categories: categories, isLoadingCategories: false));
    }).catchError((error) {
      emit(state.copyWith(errorMessage: error.toString()));
    });
  }

  void loadRecommendedProducts() {
    emit(state.copyWith(isLoadingRecommendedProducts: true));

    _repo.getRecommendedProducts().then((recommendedProducts) {
      final favIds = state.favoriteProductIds;
      emit(
        state.copyWith(
          recommendedProducts: recommendedProducts
              .map((p) => p.copyWith(isFavorite: favIds.contains(p.id)))
              .toList(),
          isLoadingRecommendedProducts: false,
        ),
      );
    }).catchError((error) {
      emit(state.copyWith(errorMessage: error.toString()));
    });
  }

  void loadPopularProducts() {
    emit(state.copyWith(isLoadingPopularProducts: true));
    _repo.getPopularProducts().then((popularProducts) {
      final updatedFavorites = state.favoriteProductIds;
      emit(state.copyWith(
        popularProducts: popularProducts
            .map((p) => p.copyWith(isFavorite: updatedFavorites.contains(p.id)))
            .toList(),
        isLoadingPopularProducts: false,
      ));
    }).catchError((error) {
      emit(state.copyWith(errorMessage: error.toString()));
    });
  }

  void favoriteProduct(Product product) {
    final updatedFavorites = List<String>.from(state.favoriteProductIds);
    if (updatedFavorites.contains(product.id)) {
      updatedFavorites.remove(product.id);
    } else {
      updatedFavorites.add(product.id);
    }
    emit(state.copyWith(
      recommendedProducts: state.recommendedProducts
          .map((p) =>
              p.id == product.id ? p.copyWith(isFavorite: !p.isFavorite) : p)
          .toList(),
      popularProducts: state.popularProducts
          .map((p) =>
              p.id == product.id ? p.copyWith(isFavorite: !p.isFavorite) : p)
          .toList(),
      favoriteProductIds: updatedFavorites,
    ));
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    log(json.toString());
    final favoriteIds = (json['favoriteProductIds'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [];
    return state.copyWith(
      favoriteProductIds: favoriteIds,
    );
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    log(state.favoriteProductIds.toString());
    return {
      'favoriteProductIds': state.favoriteProductIds,
    };
  }
}
