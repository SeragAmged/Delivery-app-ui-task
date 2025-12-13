import 'package:delivery_app/home/domain/food_category.dart';
import 'package:delivery_app/home/domain/home_products_data_source.dart';
import 'package:delivery_app/home/domain/product.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class HomeProductsRepo implements HomeProductsDataSource {
  final HomeProductsDataSource _localDataSource;

  HomeProductsRepo(
      {@Named("assets") required HomeProductsDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<List<Product>> getPopularProducts() async =>
      await _localDataSource.getPopularProducts();

  @override
  Future<List<FoodCategory>> getProductCategories() async =>
      await _localDataSource.getProductCategories();

  @override
  Future<List<Product>> getRecommendedProducts() async =>
      await _localDataSource.getRecommendedProducts();
}
