import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.dart';

part 'asset.g.dart';

part 'asset_info.dart';

part 'location.dart';

@JsonSerializable(explicitToJson: true)
class Asset extends Equatable {
  const Asset({
    required this.id,
    required this.price,
    required this.propertyType,
    required this.address,
    required this.createdAt,
    required this.searchDate,
    required this.thumbnail,
    required this.additionalInfo,
  });

  final String id;
  final int price;
  @JsonKey(name: 'property_type')
  final String propertyType;
  final Address address;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'search_date')
  final DateTime? searchDate;
  final String thumbnail;
  @JsonKey(name: 'additional_info')
  final AdditionalInfo additionalInfo;

  // additionalInfo getters
  int get bathrooms => additionalInfo.bathrooms;

  double get rooms => additionalInfo.rooms;

  int get floor => additionalInfo.floor.onThe;

  int get buildingFloors => additionalInfo.floor.outOf;

  // address getters
  String get city => address.he.cityName;

  String get street => address.he.streetName;

  String get houseNumber => address.he.houseNumber ?? '';

  String get neighborhood => address.he.neighborhood;

  // other getters
  String get title => "$street $houseNumber, $city";

  String get priceString => '$price'.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");

  double get lat => address.location.lat;

  double get lng => address.location.lng;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  Map<String, dynamic> toJson() => _$AssetToJson(this);

  @override
  List<Object?> get props => [
        id,
        price,
        propertyType,
        address,
        createdAt,
        searchDate,
        thumbnail,
        additionalInfo,
      ];
}
