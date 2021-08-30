// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantModel _$RestaurantModelFromJson(Map<String, dynamic> json) =>
    RestaurantModel(
      json['id'] as int,
      json['name'] as String,
      json['category'] as String,
      json['photo'] as String,
      json['phone'] as int,
      json['email'] as String,
      json['owner'] as String,
      json['zip'] as int,
      json['isBanned'] as bool,
    );

Map<String, dynamic> _$RestaurantModelToJson(RestaurantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'photo': instance.photo,
      'phone': instance.phone,
      'email': instance.email,
      'owner': instance.owner,
      'isBanned': instance.isBanned,
      'zip': instance.zip,
    };
