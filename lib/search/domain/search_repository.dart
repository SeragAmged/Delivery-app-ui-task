import 'package:delivery_app/core/domain/product.dart';

abstract class SearchRepository {
  Future<List<Product>> searchProducts(String query);
}
