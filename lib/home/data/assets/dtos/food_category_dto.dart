import 'package:json_annotation/json_annotation.dart';
part 'food_category_dto.g.dart';

@JsonSerializable()
class FoodCategoryDto {
  final String name;
  final String image;
  final String color;

  const FoodCategoryDto(
      {required this.name, required this.image, required this.color});

  factory FoodCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$FoodCategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FoodCategoryDtoToJson(this);
}

