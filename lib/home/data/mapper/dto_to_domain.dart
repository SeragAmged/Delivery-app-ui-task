import 'package:delivery_app/home/data/assets/dtos/food_category_dto.dart';
import 'package:delivery_app/home/data/assets/dtos/ingredient_dto.dart';
import 'package:delivery_app/home/data/assets/dtos/product_dto.dart';
import 'package:delivery_app/home/domain/food_category.dart';
import 'package:delivery_app/home/domain/ingredient.dart';
import 'package:delivery_app/home/domain/product.dart';

extension ProductDtoMapper on ProductDto {
  Product toProduct() => Product(
        id: id,
        name: name,
        description: description,
        price: price,
        imagePreview: imagePreview,
        image: image,
        isFavorite: isFavorite,
        shortDescription: shortDescription,
        type: type,
        ingredients: ingredients.map((e) => e.toIngredient()).toList(),
      );
}

extension IngredientDtoMapper on IngredientDto {
  Ingredient toIngredient() => Ingredient(name: name, image: image);
}

extension FoodCategoryDtoMapper on FoodCategoryDto {
  int parseHexColor(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) {
      hex = "FF$hex";
    }
    return int.parse(hex, radix: 16);
  }

  FoodCategory toFoodCategory() =>
      FoodCategory(name: name, image: image, color: parseHexColor(color));
}
