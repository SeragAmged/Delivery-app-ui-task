import 'package:delivery_app/core/data/assets/asset_loader.dart';
import 'package:delivery_app/home/data/assets/dtos/food_category_dto.dart';
import 'package:delivery_app/core/data/assets/dtos/product_dto.dart';
import 'package:delivery_app/home/data/mapper/food_category_dto_mapper.dart';
import 'package:delivery_app/core/data/mapper/product_dto_mapper.dart';
import 'package:delivery_app/home/domain/food_category.dart';
import 'package:delivery_app/home/domain/home_products_data_source.dart';
import 'package:delivery_app/core/domain/product.dart';
import 'package:delivery_app/assets/data.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: HomeProductsDataSource, env: [Environment.dev])
@Named('assets')
class AssetProductsDataSource implements HomeProductsDataSource {
  AssetProductsDataSource({required this.assetLoader});
  final AssetLoader assetLoader;
  @override
  Future<List<Product>> getPopularProducts() async {
    final productsDtos = await assetLoader.loadList(
        Assets.dataPopularProducts, ProductDto.fromJson);
    return productsDtos.map((productDto) => productDto.toProduct()).toList();
  }

  @override
  Future<List<FoodCategory>> getProductCategories() async {
    final categoryDtos = await assetLoader.loadList(
        Assets.dataCategories, FoodCategoryDto.fromJson);

    return categoryDtos
        .map((categoryDto) => categoryDto.toFoodCategory())
        .toList();
  }

  @override
  Future<List<Product>> getRecommendedProducts() async {
    final productsDtos = await assetLoader.loadList(
      Assets.dataRecommendedProducts,
      ProductDto.fromJson,
    );
    return productsDtos.map((productDto) => productDto.toProduct()).toList();
  }

}
