// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) => ProductDto(
      json['type'] as String,
      json['description'] as String,
      json['shortDescription'] as String,
      (json['price'] as num).toDouble(),
      json['isFavorite'] as bool,
      (json['ingredients'] as List<dynamic>)
          .map((e) => IngredientDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['id'] as String,
      json['imagePreview'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$ProductDtoToJson(ProductDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imagePreview': instance.imagePreview,
      'image': instance.image,
      'name': instance.name,
      'type': instance.type,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'price': instance.price,
      'isFavorite': instance.isFavorite,
      'ingredients': instance.ingredients,
    };
