import 'dart:async';

import 'package:assets_repository/assets_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home365_home_assignment/app/app.dart';
import 'package:home365_home_assignment/assets_map/assets_map.dart';

class AssetsMap extends StatelessWidget {
  const AssetsMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssetsMapBloc()
        ..add(const AssetsMapSubscribeUserLocation())
        ..add(AssetsMapAssetsSubscriptionRequested(
          assets: context.read<AssetsCubit>().state.assets,
        )),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AssetsCubit, AssetsState>(
              listenWhen: (previous, current) =>
                  previous.assets != current.assets,
              listener: (context, state) => context.read<AssetsMapBloc>().add(
                  AssetsMapAssetsSubscriptionRequested(assets: state.assets))),
          BlocListener<AssetsCubit, AssetsState>(
              listenWhen: (previous, current) =>
                  previous.selectedAsset != current.selectedAsset,
              listener: (context, state) => context
                  .read<AssetsMapBloc>()
                  .add(AssetsMapAssetSelected(asset: state.selectedAsset))),
        ],
        child: const _AssetsMapView(),
      ),
    );
  }
}

class _AssetsMapView extends StatefulWidget {
  const _AssetsMapView({Key? key}) : super(key: key);

  @override
  State<_AssetsMapView> createState() => _AssetsMapViewState();
}

class _AssetsMapViewState extends State<_AssetsMapView> {
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetsMapBloc, AssetsMapState>(
      builder: (context, state) {
        const loading = Center(child: CircularProgressIndicator());

        switch (state.status) {
          case AssetsMapStatus.initial:
            return loading;
          case AssetsMapStatus.loading:
            return loading;
          case AssetsMapStatus.failure:
            return const Center(child: Text("Unable to load map"));
          case AssetsMapStatus.success:
            {
              // set camera position
              _animateCameraPosition(state.cameraPosition);

              return GoogleMap(
                initialCameraPosition: state.cameraPosition,
                myLocationEnabled: state.userPosition != null,
                myLocationButtonEnabled: true,
                markers: _markers(state.assets),
                polylines: state.polylines,
                onMapCreated: (GoogleMapController controller) {
                  if (!_controller.isCompleted) {
                    _controller.complete(controller);
                  }
                },
              );
            }
        }
      },
    );
  }

  Set<Marker> _markers(List<Asset> assets) => assets
      .map((a) => Marker(
          markerId: MarkerId(a.id),
          position: LatLng(a.lat, a.lng),
          onTap: () {
            context.read<AssetsCubit>().assetSelected(a);
          }))
      .toSet();

  void _animateCameraPosition(CameraPosition cameraPosition) async {
    _mapController = await _controller.future;
    _mapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }
}
