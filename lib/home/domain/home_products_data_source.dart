import 'package:delivery_app/home/domain/food_category.dart';
import 'package:delivery_app/home/domain/product.dart';

abstract class HomeProductsDataSource {
  Future<List<FoodCategory>> getProductCategories();
  Future<List<Product>> getPopularProducts();
  Future<List<Product>> getRecommendedProducts();
}
