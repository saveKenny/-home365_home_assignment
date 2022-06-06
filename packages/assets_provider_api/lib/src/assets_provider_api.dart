abstract class AssetsProviderApi {
  const AssetsProviderApi();

  Future<List<Map<String, dynamic>>> fetchAssets();
}
