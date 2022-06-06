part of 'assets_list_bloc.dart';

abstract class AssetsListEvent extends Equatable {
  const AssetsListEvent();

  @override
  List<Object?> get props => [];
}

class AssetsListAssetsSubscriptionRequested extends AssetsListEvent {
  const AssetsListAssetsSubscriptionRequested({required this.assets});

  final List<Asset> assets;

  @override
  List<Object?> get props => [assets];
}

class AssetsListSortAssets extends AssetsListEvent {
  const AssetsListSortAssets({required this.sort});

  final AssetsListSortOptions sort;

  @override
  List<Object?> get props => [sort];
}

class AssetsListSubscribeUserLocation extends AssetsListEvent {
  const AssetsListSubscribeUserLocation();
}
