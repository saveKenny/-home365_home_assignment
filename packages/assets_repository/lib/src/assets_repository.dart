import 'package:assets_provider_api/assets_provider_api.dart';

class AssetsRepository {
  const AssetsRepository({required AssetsProviderApi assetsProviderApi})
      : _assetsProviderApi = assetsProviderApi;

  final AssetsProviderApi _assetsProviderApi;

  Future<List<Asset>> fetchAssets() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return List<Asset>.from(
        (await _assetsProviderApi.fetchAssets()).map((e) => Asset.fromJson(e)));
  }
}
