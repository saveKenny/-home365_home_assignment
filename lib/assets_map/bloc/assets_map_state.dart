part of 'assets_map_bloc.dart';

enum AssetsMapStatus { initial, loading, success, failure }

const CameraPosition _defaultCameraPosition = CameraPosition(
  target: LatLng(32.08178983344633, 34.78364920300859),
  zoom: _zoom,
);

class AssetsMapState extends Equatable {
  const AssetsMapState({
    this.status = AssetsMapStatus.initial,
    this.assets = const [],
    this.userPosition,
    this.polyline,
    this.cameraPosition = _defaultCameraPosition,
  });

  final AssetsMapStatus status;
  final List<Asset> assets;
  final Position? userPosition;
  final Polyline? polyline;
  final CameraPosition cameraPosition;

  Set<Polyline> get polylines => polyline != null ? {polyline!} : {};

  AssetsMapState copyWith({
    AssetsMapStatus? status,
    List<Asset>? assets,
    Position? userPosition,
    Polyline? polyline,
    CameraPosition? cameraPosition,
  }) {
    return AssetsMapState(
      status: status ?? this.status,
      assets: assets ?? this.assets,
      userPosition: userPosition ?? this.userPosition,
      polyline: polyline ?? this.polyline,
      cameraPosition: cameraPosition ?? this.cameraPosition,
    );
  }

  @override
  List<Object?> get props => [
        status,
        assets,
        userPosition,
        polyline,
        cameraPosition,
      ];
}
