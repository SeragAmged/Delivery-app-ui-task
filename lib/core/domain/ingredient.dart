import 'package:json_annotation/json_annotation.dart';

part 'ingredient.g.dart';
@JsonSerializable()
class Ingredient {
  final String name;
  final String image;

  const Ingredient({required this.name, required this.image});

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
