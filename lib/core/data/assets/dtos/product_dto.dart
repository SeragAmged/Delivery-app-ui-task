import 'package:delivery_app/core/data/assets/dtos/ingredient_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class ProductDto {
  final String id;
  final String imagePreview;
  final String image;
  final String name;
  final String type;
  final String description;
  final String shortDescription;
  final double price;
  final bool isFavorite;
  final List<IngredientDto> ingredients;

  const ProductDto(this.type, this.description, this.shortDescription,
      this.price, this.isFavorite, this.ingredients, this.id, this.imagePreview,
      {required this.name, required this.image});

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}
