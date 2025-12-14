import 'package:delivery_app/core/data/assets/dtos/product_dto.dart';
import 'package:delivery_app/core/domain/product.dart';
import 'package:delivery_app/core/data/mapper/ingredient_dto_mapper.dart';

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
