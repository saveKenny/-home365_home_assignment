part of 'assets_cubit.dart';

enum AssetsStatus { initial, loading, success, failure }

class AssetsState extends Equatable {
  const AssetsState({
    this.status = AssetsStatus.initial,
    this.assets = const [],
    this.selectedAsset,
  });

  final AssetsStatus status;
  final List<Asset> assets;
  final Asset? selectedAsset;

  AssetsState copyWith({
    AssetsStatus? status,
    List<Asset>? assets,
    Asset? selectedAsset,
  }) {
    return AssetsState(
      status: status ?? this.status,
      assets: assets ?? this.assets,
      selectedAsset: selectedAsset ?? this.selectedAsset,
    );
  }

  @override
  List<Object?> get props => [status, assets, selectedAsset];
}
