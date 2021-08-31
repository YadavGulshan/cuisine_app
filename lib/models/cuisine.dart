// ignore_for_file: non_constant_identifier_names

import 'package:flutter/animation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cuisine.g.dart';

@JsonSerializable()
class CuisineModel {
  int id;
  String name;
  double price;
  String image;
  int restaurant_id;

  CuisineModel(
    this.id,
    this.name,
    this.price,
    this.image,
    this.restaurant_id,
  );

  factory CuisineModel.fromJson(Map<String, dynamic> json) =>
      _$CuisineModelFromJson(json);

  Map<String, dynamic> toJson() => _$CuisineModelToJson(this);
}
