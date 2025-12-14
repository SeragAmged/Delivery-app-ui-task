import 'package:delivery_app/home/data/assets/dtos/food_category_dto.dart';
import 'package:delivery_app/home/domain/food_category.dart';

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
