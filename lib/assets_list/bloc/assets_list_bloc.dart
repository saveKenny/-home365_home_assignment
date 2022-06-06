import 'dart:async';

import 'package:assets_repository/assets_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home365_home_assignment/utils/user_location.dart';

part 'assets_list_event.dart';

part 'assets_list_state.dart';

class AssetsListBloc extends Bloc<AssetsListEvent, AssetsListState> {
  AssetsListBloc() : super(const AssetsListState()) {
    on<AssetsListAssetsSubscriptionRequested>(_onAssetsSubscriptionRequested);
    on<AssetsListSortAssets>(_onSortAssets);
    on<AssetsListSubscribeUserLocation>(_onSubscribeUserLocation);
  }

  void _onAssetsSubscriptionRequested(
      AssetsListAssetsSubscriptionRequested event,
      Emitter<AssetsListState> emit) {
    try {
      final assets = _sort(event.assets, state.sort);
      emit(state.copyWith(assets: assets, status: AssetsListStatus.success));
    } catch (_) {
      emit(state.copyWith(status: AssetsListStatus.failure));
    }
  }

  void _onSortAssets(
      AssetsListSortAssets event, Emitter<AssetsListState> emit) {
    final assets = _sort(state.assets, event.sort);
    emit(state.copyWith(assets: assets, sort: event.sort));
  }

  List<Asset> _sort(List<Asset> assets, AssetsListSortOptions sort) {
    switch (sort) {
      case AssetsListSortOptions.byName:
        assets.sort((a, b) => a.title.compareTo(b.title));
        return assets;
      case AssetsListSortOptions.byDistance:
        return assets;
    }
  }

  Future<void> _onSubscribeUserLocation(AssetsListSubscribeUserLocation event,
      Emitter<AssetsListState> emit) async {
    await emit.forEach<Position>(
      UserLocation().userPosition,
      onData: (position) => state.copyWith(
          userPosition: position, status: AssetsListStatus.success),
      onError: (_, __) => state.copyWith(status: AssetsListStatus.failure),
    );
  }
}
