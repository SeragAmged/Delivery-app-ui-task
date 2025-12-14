// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      name: json['name'] as String,
      image: json['image'] as String,
      imagePreview: json['imagePreview'] as String,
      id: json['id'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      shortDescription: json['shortDescription'] as String,
      price: (json['price'] as num).toDouble(),
      isFavorite: json['isFavorite'] as bool,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
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
