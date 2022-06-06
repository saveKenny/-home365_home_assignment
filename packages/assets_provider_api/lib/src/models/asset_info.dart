part of 'asset.dart';

@JsonSerializable(explicitToJson: true)
class AdditionalInfo extends Equatable {
  const AdditionalInfo(
      {required this.bathrooms, required this.rooms, required this.floor});

  final int bathrooms;
  final double rooms;
  final Floor floor;

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) =>
      _$AdditionalInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalInfoToJson(this);

  @override
  List<Object?> get props => [bathrooms, rooms, floor];
}

@JsonSerializable()
class Floor extends Equatable {
  const Floor({required this.onThe, required this.outOf});

  @JsonKey(name: 'on_the')
  final int onThe;
  @JsonKey(name: 'out_of')
  final int outOf;

  factory Floor.fromJson(Map<String, dynamic> json) => _$FloorFromJson(json);

  Map<String, dynamic> toJson() => _$FloorToJson(this);

  @override
  List<Object?> get props => [onThe, outOf];
}
