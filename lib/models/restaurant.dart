import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class RestaurantModel {
  int id;
  String name; // Name of the restaurant
  String category; // Short description of restaurant.
  String photo; // Photo url.
  int phone;
  String email;
  String owner;
  bool isBanned;
  int zip;

  RestaurantModel(
    this.id,
    this.name,
    this.category,
    this.photo,
    this.phone,
    this.email,
    this.owner,
    this.zip,
    this.isBanned,
  );

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}
