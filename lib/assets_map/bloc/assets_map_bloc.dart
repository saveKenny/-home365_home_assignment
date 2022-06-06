import 'dart:async';

import 'package:assets_repository/assets_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home365_home_assignment/utils/secrets.dart';
import 'package:home365_home_assignment/utils/user_location.dart';

part 'assets_map_event.dart';

part 'assets_map_state.dart';

const double _zoom = 12;

class AssetsMapBloc extends Bloc<AssetsMapEvent, AssetsMapState> {
  AssetsMapBloc() : super(const AssetsMapState()) {
    on<AssetsMapAssetsSubscriptionRequested>(_onAssetsSubscriptionRequested);
    on<AssetsMapSubscribeUserLocation>(_onSubscribeUserLocation);
    on<AssetsMapAssetSelected>(_onAssetSelected);
  }

  void _onAssetsSubscriptionRequested(
      AssetsMapAssetsSubscriptionRequested event,
      Emitter<AssetsMapState> emit) {
    emit(state.copyWith(assets: event.assets));
  }

  Future<void> _onSubscribeUserLocation(AssetsMapSubscribeUserLocation event,
      Emitter<AssetsMapState> emit) async {
    emit(state.copyWith(status: AssetsMapStatus.success));
    await emit.forEach<Position>(
      UserLocation().userPosition,
      onData: (position) {
        final cameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: _zoom);
        return state.copyWith(
          userPosition: position,
          cameraPosition: cameraPosition,
          status: AssetsMapStatus.success,
        );
      },
      onError: (_, __) => state.copyWith(status: AssetsMapStatus.failure),
    );
  }

  Future<void> _onAssetSelected(
      AssetsMapAssetSelected event, Emitter<AssetsMapState> emit) async {
    try {
      final asset = event.asset;
      if (asset == null) return;

      final Position? userPosition = state.userPosition;
      if (userPosition == null) return;

      emit(state.copyWith(status: AssetsMapStatus.loading));
      final polylines = await _direction(
        userPosition.latitude,
        userPosition.longitude,
        asset.lat,
        asset.lng,
      );
      emit(
          state.copyWith(polyline: polylines, status: AssetsMapStatus.success));
    } catch (_) {
      emit(state.copyWith(status: AssetsMapStatus.failure));
    }
  }

  Future<Polyline?> _direction(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      Secrets.GoogleMapsApiKey,
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.walking,
    );

    if (result.points.isEmpty) return null;
    return Polyline(
      polylineId: const PolylineId('poly'),
      points:
          result.points.map((p) => LatLng(p.latitude, p.longitude)).toList(),
      width: 3,
    );
  }
}
