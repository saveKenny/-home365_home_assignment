import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:home365_home_assignment/app/app.dart';
import 'package:home365_home_assignment/assets_list/assets_list.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AssetList extends StatelessWidget {
  const AssetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssetsListBloc()
        ..add(const AssetsListSubscribeUserLocation())
        ..add(AssetsListAssetsSubscriptionRequested(
            assets:
                context.read<AssetsCubit>().state.assets)), // initial assets
      child: Builder(builder: (context) {
        // listen for asset changes after initialization
        return BlocListener<AssetsListBloc, AssetsListState>(
          listenWhen: (previous, current) => previous.assets != current.assets,
          listener: (context, state) => context
              .read<AssetsListBloc>()
              .add(AssetsListAssetsSubscriptionRequested(assets: state.assets)),
          child: const _AssetListView(),
        );
      }),
    );
  }
}

class _AssetListView extends StatefulWidget {
  const _AssetListView({Key? key}) : super(key: key);

  @override
  State<_AssetListView> createState() => _AssetListViewState();
}

class _AssetListViewState extends State<_AssetListView> {
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AssetsCubit, AssetsState>(
      listener: (context, state) {
        final selectedAsset = state.selectedAsset;
        if (selectedAsset == null) return;

        final assets = context.read<AssetsListBloc>().state.assets;
        final selectedAssetIndex = assets.indexOf(selectedAsset);
        _scrollController.scrollTo(
            index: selectedAssetIndex,
            curve: Curves.easeInOutCubic,
            duration: const Duration(milliseconds: 750));
      },
      child: BlocBuilder<AssetsListBloc, AssetsListState>(
        builder: (context, state) {
          const loading = Center(child: CircularProgressIndicator());

          switch (state.status) {
            case AssetsListStatus.initial:
              return loading;
            case AssetsListStatus.loading:
              return loading;
            case AssetsListStatus.failure:
              return const Center(child: Text("Failed to list assets"));
            case AssetsListStatus.success:
              return ScrollablePositionedList.builder(
                itemScrollController: _scrollController,
                itemCount: state.assets.length,
                itemBuilder: (context, index) {
                  final asset = state.assets[index];

                  double? distanceKm;
                  final userPosition = state.userPosition;
                  if (userPosition != null) {
                    distanceKm = Geolocator.distanceBetween(
                            asset.lat,
                            asset.lng,
                            userPosition.latitude,
                            userPosition.longitude) /
                        1000;
                  }

                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: InkWell(
                        onTap: () =>
                            context.read<AssetsCubit>().assetSelected(asset),
                        child: AssetTile(asset: asset, distanceKm: distanceKm)),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
