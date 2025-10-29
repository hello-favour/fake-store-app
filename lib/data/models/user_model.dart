import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  final int id;
  final String email;
  final String username;
  final String password;
  final NameModel name;
  final AddressModel address;
  final String phone;

  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    email,
    username,
    password,
    name,
    address,
    phone,
  ];
}

@JsonSerializable()
class NameModel extends Equatable {
  final String firstname;
  final String lastname;

  const NameModel({required this.firstname, required this.lastname});

  factory NameModel.fromJson(Map<String, dynamic> json) =>
      _$NameModelFromJson(json);

  Map<String, dynamic> toJson() => _$NameModelToJson(this);

  @override
  List<Object?> get props => [firstname, lastname];
}

@JsonSerializable()
class AddressModel extends Equatable {
  final String city;
  final String street;
  final int number;
  final String zipcode;
  final GeolocationModel geolocation;

  const AddressModel({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.geolocation,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);

  @override
  List<Object?> get props => [city, street, number, zipcode, geolocation];
}

@JsonSerializable()
class GeolocationModel extends Equatable {
  final String lat;
  final String long;

  const GeolocationModel({required this.lat, required this.long});

  factory GeolocationModel.fromJson(Map<String, dynamic> json) =>
      _$GeolocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeolocationModelToJson(this);

  @override
  List<Object?> get props => [lat, long];
}
