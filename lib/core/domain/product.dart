import 'package:delivery_app/core/domain/ingredient.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product  {
  final String id;
  final String imagePreview;
  final String image;
  final String name;
  final String type;
  final String description;
  final String shortDescription;
  final double price;
  final bool isFavorite;
  final List<Ingredient> ingredients;

  const Product({
    required this.name,
    required this.image,
    required this.imagePreview,
    required this.id,
    required this.type,
    required this.description,
    required this.shortDescription,
    required this.price,
    required this.isFavorite,
    required this.ingredients,
  });

  Product copyWith({
    String? name,
    String? image,
    String? imagePreview,
    String? id,
    String? type,
    String? description,
    String? shortDescription,
    double? price,
    bool? isFavorite,
    List<Ingredient>? ingredients,
  }) {
    return Product(
      name: name ?? this.name,
      image: image ?? this.image,
      imagePreview: imagePreview ?? this.imagePreview,
      id: id ?? this.id,
      type: type ?? this.type,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
