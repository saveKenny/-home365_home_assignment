part of 'asset.dart';
@JsonSerializable(explicitToJson: true)
class Address extends Equatable {
  const Address({required this.location, required this.he});

  final Location location;
  final He he;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  List<Object?> get props => [location, he];
}

@JsonSerializable()
class He extends Equatable {
  const He({
    required this.cityName,
    required this.houseNumber,
    required this.streetName,
    required this.neighborhood,
  });

  @JsonKey(name: 'city_name')
  final String cityName;
  @JsonKey(name: 'house_number')
  final String? houseNumber;
  @JsonKey(name: 'street_name')
  final String streetName;
  @JsonKey(name: 'neighborhood')
  final String neighborhood;

  factory He.fromJson(Map<String, dynamic> json) => _$HeFromJson(json);

  Map<String, dynamic> toJson() => _$HeToJson(this);

  @override
  List<Object?> get props => [cityName, houseNumber, streetName, neighborhood];
}
