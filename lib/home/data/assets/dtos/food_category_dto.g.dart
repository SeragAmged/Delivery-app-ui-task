// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodCategoryDto _$FoodCategoryDtoFromJson(Map<String, dynamic> json) =>
    FoodCategoryDto(
      name: json['name'] as String,
      image: json['image'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$FoodCategoryDtoToJson(FoodCategoryDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'color': instance.color,
    };
