import 'dart:convert';

import 'package:assets_provider_api/assets_provider_api.dart';
import 'package:flutter/services.dart';

const String _path = 'packages/assets_json_provider/assets/properties.json';

class AssetsJsonProvider extends AssetsProviderApi {
  const AssetsJsonProvider();

  @override
  Future<List<Map<String, dynamic>>> fetchAssets() async {
    return List.from((await _readJson())['data']);
  }

  Future<Map<String, dynamic>> _readJson([String path = _path]) async {
    final String response = await rootBundle.loadString(path);
    return json.decode(response);
  }
}
