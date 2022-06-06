part of 'assets_list_bloc.dart';

enum AssetsListStatus { initial, loading, success, failure }
enum AssetsListSortOptions { byName, byDistance }

class AssetsListState extends Equatable {
  const AssetsListState({
    this.status = AssetsListStatus.initial,
    this.sort = AssetsListSortOptions.byName,
    this.assets = const [],
    this.userPosition,
  });

  final AssetsListStatus status;
  final AssetsListSortOptions sort;
  final List<Asset> assets;
  final Position? userPosition;

  AssetsListState copyWith({
    AssetsListStatus? status,
    AssetsListSortOptions? sort,
    List<Asset>? assets,
    Position? userPosition,
  }) {
    return AssetsListState(
      status: status ?? this.status,
      sort: sort ?? this.sort,
      assets: assets ?? this.assets,
      userPosition: userPosition ?? this.userPosition,
    );
  }

  @override
  List<Object?> get props => [status, sort, assets, userPosition];
}
