import 'package:delivery_app/core/data/assets/dtos/ingredient_dto.dart';
import 'package:delivery_app/core/domain/ingredient.dart';

extension IngredientDtoMapper on IngredientDto {
  Ingredient toIngredient() => Ingredient(name: name, image: image);
}
