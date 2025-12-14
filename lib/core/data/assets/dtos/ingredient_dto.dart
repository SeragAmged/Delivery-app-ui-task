import 'package:json_annotation/json_annotation.dart';
part 'ingredients.g.dart';

@JsonSerializable()
class IngredientDto {
  final String name;
  final String image;

  const IngredientDto({required this.name, required this.image});

  factory IngredientDto.fromJson(Map<String, dynamic> json) =>
      _$IngredientsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientsDtoToJson(this);
}
