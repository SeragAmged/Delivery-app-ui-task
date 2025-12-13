import 'package:delivery_app/home/data/assets/asset_loader.dart';
import 'package:delivery_app/home/data/assets/dtos/food_category_dto.dart';
import 'package:delivery_app/home/data/assets/dtos/product_dto.dart';
import 'package:delivery_app/home/data/mapper/dto_to_domain.dart';
import 'package:delivery_app/home/domain/food_category.dart';
import 'package:delivery_app/home/domain/home_products_data_source.dart';
import 'package:delivery_app/home/domain/product.dart';
import 'package:delivery_app/assets/data.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: HomeProductsDataSource,env: [Environment.dev]) 
@Named('assets')
class AssetProductsDataSource implements HomeProductsDataSource {
  AssetProductsDataSource({AssetLoader? assetLoader})
      : assetLoader = assetLoader ?? AssetLoader();
  final AssetLoader assetLoader;
  @override
  Future<List<Product>> getPopularProducts() async {
    final productsDtos = await assetLoader.loadList(
        Assets.dataPopularProducts, ProductDto.fromJson);
    // final repeated = _repeatList(productsDtos, 3);
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
        Assets.dataRecommendedProducts, ProductDto.fromJson);
    final repeated = _repeatList(productsDtos, 3);
    return repeated.map((productDto) => productDto.toProduct()).toList();
  }

  List<T> _repeatList<T>(List<T> list, int times) {
    return List<T>.generate(
        list.length * times, (index) => list[index % list.length]);
  }
}
