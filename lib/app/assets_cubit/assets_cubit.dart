import 'package:assets_repository/assets_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'assets_state.dart';

class AssetsCubit extends Cubit<AssetsState> {
  AssetsCubit({required AssetsRepository assetsRepository})
      : _assetsRepository = assetsRepository,
        super(const AssetsState());

  final AssetsRepository _assetsRepository;

  Future<void> fetchAssets() async {
    try {
      emit(state.copyWith(status: AssetsStatus.loading));
      final assets = await _assetsRepository.fetchAssets();
      emit(state.copyWith(status: AssetsStatus.success, assets: assets));
    } catch (e) {
      emit(state.copyWith(status: AssetsStatus.failure));
    }
  }

  void assetSelected(Asset asset) => emit(state.copyWith(selectedAsset: asset));
}
