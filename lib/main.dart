import 'package:assets_json_provider/assets_json_provider.dart';
import 'package:assets_repository/assets_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home365_home_assignment/app/observer.dart';
import 'package:home365_home_assignment/app/view/app.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      const _assetsProviderApi = AssetsJsonProvider();
      const _assetsRepository =
          AssetsRepository(assetsProviderApi: _assetsProviderApi);

      if (defaultTargetPlatform == TargetPlatform.android) {
        AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
      }
      runApp(const App(assetsRepository: _assetsRepository));
    },
    blocObserver: AppBlocObserver(),
  );
}
