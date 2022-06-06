part of 'asset.dart';

@JsonSerializable()
class Location extends Equatable {
  const Location({required this.lat, required this.lng});

  final double lat;
  @JsonKey(name: 'lon')
  final double lng;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  List<Object?> get props => [lat, lng];
}
