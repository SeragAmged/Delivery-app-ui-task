import 'package:delivery_app/assets/data.dart';
import 'package:delivery_app/core/data/assets/asset_loader.dart';
import 'package:delivery_app/core/data/assets/dtos/product_dto.dart';
import 'package:delivery_app/core/data/mapper/product_dto_mapper.dart';
import 'package:delivery_app/core/domain/product.dart';
import 'package:delivery_app/search/domain/search_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final AssetLoader _assetLoader;

  SearchRepositoryImpl(this._assetLoader);

  @override
  Future<List<Product>> searchProducts(String query) async {
    if (query.isEmpty) return [];

    final popularProducts = await _assetLoader.loadList(
      Assets.dataPopularProducts,
      ProductDto.fromJson,
    );
    final recommendedProducts = await _assetLoader.loadList(
      Assets.dataRecommendedProducts,
      ProductDto.fromJson,
    );

    final allProducts = [
      ...popularProducts.map((dto) => dto.toProduct()),
      ...recommendedProducts.map((dto) => dto.toProduct()),
    ];

    final uniqueProducts = <String, Product>{};
    for (var product in allProducts) {
      uniqueProducts[product.id] = product;
    }

    final queryLower = query.toLowerCase();

    return uniqueProducts.values.where((product) {
      return product.name.toLowerCase().contains(queryLower) ||
          product.type.toLowerCase().contains(queryLower) ||
          product.shortDescription.toLowerCase().contains(queryLower);
    }).toList();
  }
}
