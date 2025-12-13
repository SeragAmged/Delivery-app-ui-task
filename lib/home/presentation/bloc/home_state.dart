part of 'home_cubit.dart';

class HomeState extends Equatable {
  final bool isLoadingCategories;
  final bool isLoadingRecommendedProducts;
  final bool isLoadingPopularProducts;
  final List<FoodCategory> categories;
  final List<Product> recommendedProducts;
  final List<Product> popularProducts;
  final List<String> favoriteProductIds;
  final String? errorMessage;

  const HomeState({
    this.errorMessage,
    required this.favoriteProductIds,
    required this.isLoadingCategories,
    required this.isLoadingRecommendedProducts,
    required this.isLoadingPopularProducts,
    required this.categories,
    required this.recommendedProducts,
    required this.popularProducts,
  });

  @override
  List<Object?> get props => [
        isLoadingCategories,
        isLoadingRecommendedProducts,
        isLoadingPopularProducts,
        categories,
        recommendedProducts,
        popularProducts,
        errorMessage,
        favoriteProductIds
      ];

  HomeState copyWith({
    bool? isLoadingCategories,
    bool? isLoadingRecommendedProducts,
    bool? isLoadingPopularProducts,
    List<FoodCategory>? categories,
    List<Product>? recommendedProducts,
    List<Product>? popularProducts,
    String? errorMessage,
    List<String>? favoriteProductIds,
  }) {
    return HomeState(
      isLoadingCategories: isLoadingCategories ?? this.isLoadingCategories,
      isLoadingRecommendedProducts:
          isLoadingRecommendedProducts ?? this.isLoadingRecommendedProducts,
      isLoadingPopularProducts:
          isLoadingPopularProducts ?? this.isLoadingPopularProducts,
      categories: categories ?? this.categories,
      recommendedProducts: recommendedProducts ?? this.recommendedProducts,
      popularProducts: popularProducts ?? this.popularProducts,
      errorMessage: errorMessage ?? this.errorMessage,
      favoriteProductIds: favoriteProductIds ?? this.favoriteProductIds,
    );
  }
}
