// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cuisine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CuisineModel _$CuisineModelFromJson(Map<String, dynamic> json) => CuisineModel(
      json['id'] as int,
      json['name'] as String,
      (json['price'] as num).toDouble(),
      json['image'] as String,
      json['restaurant_id'] as int,
    );

Map<String, dynamic> _$CuisineModelToJson(CuisineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'image': instance.image,
      'restaurant_id': instance.restaurant_id,
    };
