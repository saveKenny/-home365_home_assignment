part of 'assets_map_bloc.dart';

abstract class AssetsMapEvent extends Equatable {
  const AssetsMapEvent();

  @override
  List<Object?> get props => [];
}

class AssetsMapAssetsSubscriptionRequested extends AssetsMapEvent {
  const AssetsMapAssetsSubscriptionRequested({required this.assets});

  final List<Asset> assets;

  @override
  List<Object?> get props => [assets];
}

class AssetsMapSubscribeUserLocation extends AssetsMapEvent {
  const AssetsMapSubscribeUserLocation();
}

class AssetsMapAssetSelected extends AssetsMapEvent {
  const AssetsMapAssetSelected({required this.asset});

  final Asset? asset;

  @override
  List<Object?> get props => [asset];
}
