// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset(
      id: json['id'] as String,
      price: json['price'] as int,
      propertyType: json['property_type'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      searchDate: json['search_date'] == null
          ? null
          : DateTime.parse(json['search_date'] as String),
      thumbnail: json['thumbnail'] as String,
      additionalInfo: AdditionalInfo.fromJson(
          json['additional_info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'property_type': instance.propertyType,
      'address': instance.address.toJson(),
      'created_at': instance.createdAt.toIso8601String(),
      'search_date': instance.searchDate?.toIso8601String(),
      'thumbnail': instance.thumbnail,
      'additional_info': instance.additionalInfo.toJson(),
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      he: He.fromJson(json['he'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'location': instance.location.toJson(),
      'he': instance.he.toJson(),
    };

He _$HeFromJson(Map<String, dynamic> json) => He(
      cityName: json['city_name'] as String,
      houseNumber: json['house_number'] as String?,
      streetName: json['street_name'] as String,
      neighborhood: json['neighborhood'] as String,
    );

Map<String, dynamic> _$HeToJson(He instance) => <String, dynamic>{
      'city_name': instance.cityName,
      'house_number': instance.houseNumber,
      'street_name': instance.streetName,
      'neighborhood': instance.neighborhood,
    };

AdditionalInfo _$AdditionalInfoFromJson(Map<String, dynamic> json) =>
    AdditionalInfo(
      bathrooms: json['bathrooms'] as int,
      rooms: (json['rooms'] as num).toDouble(),
      floor: Floor.fromJson(json['floor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdditionalInfoToJson(AdditionalInfo instance) =>
    <String, dynamic>{
      'bathrooms': instance.bathrooms,
      'rooms': instance.rooms,
      'floor': instance.floor.toJson(),
    };

Floor _$FloorFromJson(Map<String, dynamic> json) => Floor(
      onThe: json['on_the'] as int,
      outOf: json['out_of'] as int,
    );

Map<String, dynamic> _$FloorToJson(Floor instance) => <String, dynamic>{
      'on_the': instance.onThe,
      'out_of': instance.outOf,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lon'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lng,
    };
